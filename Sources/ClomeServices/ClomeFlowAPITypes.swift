import Foundation

// MARK: - Local JSONValue (replaces GoogleGenerativeAI.JSONValue)

public enum JSONValue: Codable, Equatable, Sendable {
    case null
    case number(Double)
    case string(String)
    case bool(Bool)
    case object(JSONObject)
    case array([JSONValue])

    // MARK: - Codable

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self = .null
        } else if let b = try? container.decode(Bool.self) {
            self = .bool(b)
        } else if let n = try? container.decode(Double.self) {
            self = .number(n)
        } else if let s = try? container.decode(String.self) {
            self = .string(s)
        } else if let arr = try? container.decode([JSONValue].self) {
            self = .array(arr)
        } else if let obj = try? container.decode(JSONObject.self) {
            self = .object(obj)
        } else {
            self = .null
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null: try container.encodeNil()
        case .number(let n): try container.encode(n)
        case .string(let s): try container.encode(s)
        case .bool(let b): try container.encode(b)
        case .object(let obj): try container.encode(obj)
        case .array(let arr): try container.encode(arr)
        }
    }

    // MARK: - Convenience accessors

    public var stringValue: String? {
        if case .string(let s) = self { return s }
        return nil
    }

    public var coercedStringValue: String? {
        switch self {
        case .string(let s): return s
        case .number(let n):
            if n == n.rounded(.towardZero) { return String(Int(n)) }
            return String(n)
        case .bool(let b): return String(b)
        case .null: return nil
        case .object, .array: return nil
        }
    }

    public var numberValue: Double? {
        switch self {
        case .number(let n): return n
        case .string(let s): return Double(s)
        default: return nil
        }
    }

    public var arrayValue: [JSONValue]? {
        if case .array(let arr) = self { return arr }
        return nil
    }

    public var objectValue: JSONObject? {
        if case .object(let obj) = self { return obj }
        return nil
    }

    public var boolValue: Bool? {
        if case .bool(let b) = self { return b }
        return nil
    }
}

public typealias JSONObject = [String: JSONValue]

// MARK: - JSONValue ↔ Any conversion

extension JSONValue {
    public static func from(_ any: Any) -> JSONValue {
        if any is NSNull {
            return .null
        } else if let s = any as? String {
            return .string(s)
        } else if let b = any as? Bool {
            return .bool(b)
        } else if let n = any as? NSNumber {
            return .number(n.doubleValue)
        } else if let arr = any as? [Any] {
            return .array(arr.map { JSONValue.from($0) })
        } else if let dict = any as? [String: Any] {
            return .object(dict.mapValues { JSONValue.from($0) })
        }
        return .null
    }

    public var rawValue: Any {
        switch self {
        case .null: return NSNull()
        case .number(let n): return n
        case .string(let s): return s
        case .bool(let b): return b
        case .object(let obj): return obj.mapValues { $0.rawValue }
        case .array(let arr): return arr.map { $0.rawValue }
        }
    }
}

// MARK: - Generation Config

public struct ClomeFlowGenerationConfig: Sendable {
    public var temperature: Double
    public var maxOutputTokens: Int

    public init(temperature: Double = 0.3, maxOutputTokens: Int = 8192) {
        self.temperature = temperature
        self.maxOutputTokens = maxOutputTokens
    }

    public func toDict() -> [String: Any] {
        return [
            "temperature": temperature,
            "maxOutputTokens": maxOutputTokens,
        ]
    }
}

// MARK: - Function Declaration

public struct ClomeFlowFunctionDeclaration: @unchecked Sendable {
    public let name: String
    public let description: String
    public let parameters: [String: Any]
    public let requiredParameters: [String]

    public init(name: String, description: String, parameters: [String: Any], requiredParameters: [String]) {
        self.name = name
        self.description = description
        self.parameters = parameters
        self.requiredParameters = requiredParameters
    }

    public func toDict() -> [String: Any] {
        var schema: [String: Any] = [
            "type": "OBJECT",
            "properties": parameters,
        ]
        if !requiredParameters.isEmpty {
            schema["required"] = requiredParameters
        }
        return [
            "name": name,
            "description": description,
            "parameters": schema,
        ]
    }
}

// MARK: - Parsed Response Types

public struct ClomeFlowFunctionCall: Sendable {
    public let name: String
    public let args: JSONObject

    public init(name: String, args: JSONObject) {
        self.name = name
        self.args = args
    }
}

public enum ClomeFlowPart: Sendable {
    case text(String)
    case functionCall(ClomeFlowFunctionCall)
}

public struct ClomeFlowCandidate: Sendable {
    public let parts: [ClomeFlowPart]

    public init(parts: [ClomeFlowPart]) {
        self.parts = parts
    }
}

public struct ClomeFlowGeminiResponse: Sendable {
    public let candidates: [ClomeFlowCandidate]

    public init(candidates: [ClomeFlowCandidate]) {
        self.candidates = candidates
    }

    public var text: String? {
        for candidate in candidates {
            for part in candidate.parts {
                if case .text(let t) = part {
                    return t
                }
            }
        }
        return nil
    }
}

// MARK: - API Errors

public enum ClomeFlowAPIError: Error, LocalizedError, Sendable {
    case notAuthenticated
    case dailyLimitReached(messagesUsed: Int, limit: Int)
    case serverError(statusCode: Int, message: String)
    case networkError(Error)
    case invalidResponse
    case premiumRequired

    public var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "Please sign in to use Clome Flow's AI features."
        case .dailyLimitReached(_, let limit):
            return "You've reached your daily limit of \(limit) AI messages. Upgrade to Premium for unlimited access."
        case .serverError(let code, let message):
            return "Server error (\(code)): \(message)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .premiumRequired:
            return "This feature requires a Premium subscription."
        }
    }

    public static func == (lhs: ClomeFlowAPIError, rhs: ClomeFlowAPIError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}

// MARK: - Response Parsing

public enum ClomeFlowResponseParser {
    public static func parse(data: Data) throws -> ClomeFlowGeminiResponse {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw ClomeFlowAPIError.invalidResponse
        }

        if let error = json["error"] as? String {
            if error == "daily_limit_reached" {
                let used = json["messagesUsed"] as? Int ?? 0
                let limit = json["limit"] as? Int ?? 10
                throw ClomeFlowAPIError.dailyLimitReached(messagesUsed: used, limit: limit)
            }
            throw ClomeFlowAPIError.serverError(statusCode: 0, message: error)
        }

        guard let candidatesJSON = json["candidates"] as? [[String: Any]] else {
            throw ClomeFlowAPIError.invalidResponse
        }

        let candidates = candidatesJSON.compactMap { candidateJSON -> ClomeFlowCandidate? in
            guard let content = candidateJSON["content"] as? [String: Any],
                  let partsJSON = content["parts"] as? [[String: Any]] else {
                return nil
            }

            let parts: [ClomeFlowPart] = partsJSON.compactMap { partJSON in
                if let text = partJSON["text"] as? String {
                    return .text(text)
                }
                if let functionCallJSON = partJSON["functionCall"] as? [String: Any],
                   let name = functionCallJSON["name"] as? String {
                    let argsRaw = functionCallJSON["args"] as? [String: Any] ?? [:]
                    let args = argsRaw.mapValues { JSONValue.from($0) }
                    return .functionCall(ClomeFlowFunctionCall(name: name, args: args))
                }
                return nil
            }

            return ClomeFlowCandidate(parts: parts)
        }

        return ClomeFlowGeminiResponse(candidates: candidates)
    }
}
