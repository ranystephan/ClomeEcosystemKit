import Foundation
import FirebaseAuth
import ClomeModels

/// Single point of contact for all AI calls. Sends authenticated requests
/// to the Firebase Cloud Function proxy. Shared between Clome and Clome Flow.
@MainActor
public class ClomeFlowAPIClient {
    public static let shared = ClomeFlowAPIClient()

    // MARK: - Configuration

    private let proxyBaseURL = "https://us-central1-dora-caa03.cloudfunctions.net/geminiProxy"

    private init() {}

    // MARK: - Public API

    /// Single-shot generation (for briefings, categorization, batch operations).
    public func generateContent(
        prompt: String,
        systemInstruction: String? = nil,
        generationConfig: ClomeFlowGenerationConfig = .init(),
        tools: [[String: Any]]? = nil,
        model: String? = nil
    ) async throws -> ClomeFlowGeminiResponse {
        let contents: [[String: Any]] = [
            ["role": "user", "parts": [["text": prompt]]]
        ]

        return try await sendRequest(
            contents: contents,
            systemInstruction: systemInstruction,
            generationConfig: generationConfig,
            tools: tools,
            model: model
        )
    }

    /// Chat-style generation with full conversation history.
    public func sendChatMessage(
        contents: [[String: Any]],
        systemInstruction: String? = nil,
        generationConfig: ClomeFlowGenerationConfig = .init(),
        tools: [[String: Any]]? = nil,
        model: String? = nil
    ) async throws -> ClomeFlowGeminiResponse {
        return try await sendRequest(
            contents: contents,
            systemInstruction: systemInstruction,
            generationConfig: generationConfig,
            tools: tools,
            model: model
        )
    }

    // MARK: - Private

    private func sendRequest(
        contents: [[String: Any]],
        systemInstruction: String?,
        generationConfig: ClomeFlowGenerationConfig,
        tools: [[String: Any]]?,
        model: String? = nil
    ) async throws -> ClomeFlowGeminiResponse {
        guard let user = Auth.auth().currentUser else {
            throw ClomeFlowAPIError.notAuthenticated
        }

        let token: String
        do {
            token = try await user.getIDToken()
        } catch {
            throw ClomeFlowAPIError.notAuthenticated
        }

        var body: [String: Any] = [
            "contents": contents,
            "generationConfig": generationConfig.toDict(),
        ]

        if let model = model {
            body["model"] = model
        }

        if let systemInstruction = systemInstruction {
            body["systemInstruction"] = [
                "parts": [["text": systemInstruction]]
            ]
        }

        if let tools = tools {
            body["tools"] = [
                ["functionDeclarations": tools]
            ]
        }

        guard let url = URL(string: proxyBaseURL) else {
            throw ClomeFlowAPIError.invalidResponse
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 60

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw ClomeFlowAPIError.networkError(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ClomeFlowAPIError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            break
        case 401:
            throw ClomeFlowAPIError.notAuthenticated
        case 429:
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                let used = json["messagesUsed"] as? Int ?? 0
                let limit = json["limit"] as? Int ?? 10
                throw ClomeFlowAPIError.dailyLimitReached(messagesUsed: used, limit: limit)
            }
            throw ClomeFlowAPIError.dailyLimitReached(messagesUsed: 0, limit: 10)
        default:
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw ClomeFlowAPIError.serverError(statusCode: httpResponse.statusCode, message: message)
        }

        return try ClomeFlowResponseParser.parse(data: data)
    }
}
