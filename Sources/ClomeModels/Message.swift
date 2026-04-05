import Foundation

public struct PendingReminderInfo: Codable, Sendable {
    public let title: String
    public let dueDate: String?
    public let dueTime: String?
    public let priority: String?
    public let notes: String?

    public init(title: String, dueDate: String? = nil, dueTime: String? = nil, priority: String? = nil, notes: String? = nil) {
        self.title = title
        self.dueDate = dueDate
        self.dueTime = dueTime
        self.priority = priority
        self.notes = notes
    }
}

public struct ScheduledEventInfo: Identifiable, Codable, Sendable {
    public let id: UUID
    public let title: String
    public let startDate: Date
    public let endDate: Date
    public let location: String?

    public init(id: UUID = UUID(), title: String, startDate: Date, endDate: Date, location: String? = nil) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
    }
}

// MARK: - Suggested Action

public struct SuggestedAction: Identifiable, Codable, Sendable {
    public let id: UUID
    public let label: String
    public let icon: String?
    public let action: String

    public init(id: UUID = UUID(), label: String, icon: String? = nil, action: String) {
        self.id = id
        self.label = label
        self.icon = icon
        self.action = action
    }
}

// MARK: - Message

public struct Message: Identifiable, Codable, Sendable {
    public let id: UUID
    public let content: String
    public let isUser: Bool
    public let timestamp: Date
    public var scheduledEvents: [ScheduledEventInfo]?
    public var pendingReminder: PendingReminderInfo?
    public var isTypingIndicator: Bool
    public var suggestedActions: [SuggestedAction]?
    public var planCards: [PlanCard]?
    public var isStreaming: Bool
    public var notePreviewID: UUID?

    public init(
        id: UUID = UUID(),
        content: String,
        isUser: Bool,
        timestamp: Date = Date(),
        scheduledEvents: [ScheduledEventInfo]? = nil,
        pendingReminder: PendingReminderInfo? = nil,
        isTypingIndicator: Bool = false,
        suggestedActions: [SuggestedAction]? = nil,
        planCards: [PlanCard]? = nil,
        isStreaming: Bool = false,
        notePreviewID: UUID? = nil
    ) {
        self.id = id
        self.content = content
        self.isUser = isUser
        self.timestamp = timestamp
        self.scheduledEvents = scheduledEvents
        self.pendingReminder = pendingReminder
        self.isTypingIndicator = isTypingIndicator
        self.suggestedActions = suggestedActions
        self.planCards = planCards
        self.isStreaming = isStreaming
        self.notePreviewID = notePreviewID
    }
}
