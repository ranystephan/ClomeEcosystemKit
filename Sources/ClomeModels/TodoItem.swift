import Foundation

// MARK: - Todo Priority

public enum TodoPriority: String, Codable, CaseIterable, Sendable {
    case high
    case medium
    case low

    public var displayName: String {
        switch self {
        case .high:   return "High"
        case .medium: return "Medium"
        case .low:    return "Low"
        }
    }

    public var icon: String {
        switch self {
        case .high:   return "exclamationmark.circle.fill"
        case .medium: return "minus.circle.fill"
        case .low:    return "arrow.down.circle.fill"
        }
    }

    public var sortOrder: Int {
        switch self {
        case .high:   return 0
        case .medium: return 1
        case .low:    return 2
        }
    }
}

// MARK: - Todo Item

public struct TodoItem: Codable, Identifiable, Sendable {
    public let id: UUID
    public var title: String
    public var notes: String?
    public var category: HabitCategory
    public var priority: TodoPriority
    public var tags: [String]
    public var isCompleted: Bool
    public var completedDate: Date?
    public let createdDate: Date
    public var scheduledDate: Date?
    public var scheduledEndDate: Date?

    public init(
        id: UUID = UUID(),
        title: String,
        notes: String? = nil,
        category: HabitCategory = .general,
        priority: TodoPriority = .medium,
        tags: [String] = [],
        isCompleted: Bool = false,
        completedDate: Date? = nil,
        createdDate: Date = Date(),
        scheduledDate: Date? = nil,
        scheduledEndDate: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.notes = notes
        self.category = category
        self.priority = priority
        self.tags = tags
        self.isCompleted = isCompleted
        self.completedDate = completedDate
        self.createdDate = createdDate
        self.scheduledDate = scheduledDate
        self.scheduledEndDate = scheduledEndDate
    }
}
