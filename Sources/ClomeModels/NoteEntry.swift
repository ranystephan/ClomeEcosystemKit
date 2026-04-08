import Foundation

public enum NoteCategory: String, Codable, CaseIterable, Sendable {
    case idea
    case task
    case reminder
    case goal
    case journal
    case reference

    public var displayName: String {
        switch self {
        case .idea: return "Idea"
        case .task: return "Task"
        case .reminder: return "Reminder"
        case .goal: return "Goal"
        case .journal: return "Journal"
        case .reference: return "Reference"
        }
    }

    public var icon: String {
        switch self {
        case .idea: return "lightbulb.fill"
        case .task: return "checkmark.circle.fill"
        case .reminder: return "bell.fill"
        case .goal: return "flag.fill"
        case .journal: return "book.fill"
        case .reference: return "bookmark.fill"
        }
    }
}

public struct ActionItem: Codable, Identifiable, Sendable {
    public let id: UUID
    public let description: String
    public var isScheduled: Bool
    public var scheduledEventTitle: String?

    public init(id: UUID = UUID(), description: String, isScheduled: Bool = false, scheduledEventTitle: String? = nil) {
        self.id = id
        self.description = description
        self.isScheduled = isScheduled
        self.scheduledEventTitle = scheduledEventTitle
    }
}

// MARK: - Note Conversation Message

public struct NoteConversationMessage: Codable, Identifiable, Sendable {
    public let id: UUID
    public let content: String
    public let isUser: Bool
    public let timestamp: Date

    public init(id: UUID = UUID(), content: String, isUser: Bool, timestamp: Date = Date()) {
        self.id = id
        self.content = content
        self.isUser = isUser
        self.timestamp = timestamp
    }
}

// MARK: - Note Entry

public struct NoteEntry: Codable, Identifiable, Sendable {
    public let id: UUID
    /// The workspace this note belongs to. Optional only during the
    /// migration window — nil values are coerced to the user's Personal
    /// workspace ID by the sync layer at read time.
    /// See `docs/flow-workspaces-spec.md` § 3.6.
    public var workspaceId: String?
    public let rawContent: String
    public var summary: String
    public var category: NoteCategory
    public var actionItems: [ActionItem]
    public var aiResponse: String
    public let createdAt: Date
    public var updatedAt: Date
    public var isDone: Bool
    public var conversationHistory: [NoteConversationMessage]
    public var formattedContent: String

    public init(
        id: UUID = UUID(),
        workspaceId: String? = nil,
        rawContent: String,
        summary: String,
        category: NoteCategory,
        actionItems: [ActionItem] = [],
        aiResponse: String = "",
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        isDone: Bool = false,
        conversationHistory: [NoteConversationMessage] = [],
        formattedContent: String = ""
    ) {
        self.id = id
        self.workspaceId = workspaceId
        self.rawContent = rawContent
        self.summary = summary
        self.category = category
        self.actionItems = actionItems
        self.aiResponse = aiResponse
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isDone = isDone
        self.conversationHistory = conversationHistory
        self.formattedContent = formattedContent
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        workspaceId = try container.decodeIfPresent(String.self, forKey: .workspaceId)
        rawContent = try container.decode(String.self, forKey: .rawContent)
        summary = try container.decode(String.self, forKey: .summary)
        category = try container.decode(NoteCategory.self, forKey: .category)
        actionItems = try container.decode([ActionItem].self, forKey: .actionItems)
        aiResponse = try container.decode(String.self, forKey: .aiResponse)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        isDone = try container.decodeIfPresent(Bool.self, forKey: .isDone) ?? false
        conversationHistory = try container.decodeIfPresent([NoteConversationMessage].self, forKey: .conversationHistory) ?? []
        formattedContent = try container.decodeIfPresent(String.self, forKey: .formattedContent) ?? ""
    }
}
