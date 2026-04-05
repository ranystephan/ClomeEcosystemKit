import Foundation

// MARK: - AI Briefing Model

public struct AIBriefing: Codable, Sendable {
    public let generatedAt: Date
    public let narrative: String
    public let priorities: [String]
    public let suggestions: [BriefingSuggestion]
    public let mood: String

    public init(generatedAt: Date, narrative: String, priorities: [String], suggestions: [BriefingSuggestion], mood: String) {
        self.generatedAt = generatedAt
        self.narrative = narrative
        self.priorities = priorities
        self.suggestions = suggestions
        self.mood = mood
    }

    public var isStale: Bool {
        let hoursSince = Date().timeIntervalSince(generatedAt) / 3600
        if hoursSince > 3 { return true }
        return !Calendar.current.isDateInToday(generatedAt)
    }
}

public struct BriefingSuggestion: Codable, Identifiable, Sendable {
    public let id: UUID
    public let title: String
    public let subtitle: String?
    public let prefillAction: String
    public let icon: String
    public let tintColorHex: String

    public init(
        id: UUID = UUID(),
        title: String,
        subtitle: String? = nil,
        prefillAction: String,
        icon: String = "sparkles",
        tintColorHex: String = "007AFF"
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.prefillAction = prefillAction
        self.icon = icon
        self.tintColorHex = tintColorHex
    }
}
