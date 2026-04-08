import Foundation

// MARK: - Task Priority
//
// Renamed from `TodoPriority` for clarity. The raw values match
// `TodoPriority` so existing Firestore documents decode without conversion.

public enum TaskPriority: String, Codable, CaseIterable, Sendable {
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

// MARK: - TaskItem
//
// Successor to `TodoItem`. First-class on both platforms (per spec D2).
// `workspaceId` is required for any task created post-migration; the field
// is optional in the Codable shape so legacy documents decode cleanly during
// the migration window.
//
// See `docs/flow-workspaces-spec.md` § 3.4.

public struct TaskItem: Codable, Identifiable, Sendable {
    public let id: UUID

    /// The workspace this task belongs to. Nil only for documents written
    /// before the workspace migration ran; nil values are coerced to the
    /// user's Personal workspace ID at read time by the sync layer.
    public var workspaceId: String?

    public var title: String
    public var notes: String?
    public var category: HabitCategory
    public var priority: TaskPriority
    public var tags: [String]
    public var isCompleted: Bool
    public var completedDate: Date?
    public let createdDate: Date
    public var scheduledDate: Date?
    public var scheduledEndDate: Date?

    /// If this task was extracted from a note's action items list, the parent
    /// note's UUID. Nil for free-floating tasks. Used by the iOS migration to
    /// preserve provenance and by the Mac UI to surface a "from note" link.
    public var parentNoteId: UUID?

    public init(
        id: UUID = UUID(),
        workspaceId: String? = nil,
        title: String,
        notes: String? = nil,
        category: HabitCategory = .general,
        priority: TaskPriority = .medium,
        tags: [String] = [],
        isCompleted: Bool = false,
        completedDate: Date? = nil,
        createdDate: Date = Date(),
        scheduledDate: Date? = nil,
        scheduledEndDate: Date? = nil,
        parentNoteId: UUID? = nil
    ) {
        self.id = id
        self.workspaceId = workspaceId
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
        self.parentNoteId = parentNoteId
    }
}

// MARK: - Bridging from legacy TodoItem
//
// One-shot conversion used by the migration step. Both apps call this when
// reading any document still at the legacy `users/{uid}/sync/todoStore`
// path during Phase 2 migration.

public extension TaskItem {
    init(legacy todo: TodoItem, workspaceId: String) {
        self.init(
            id: todo.id,
            workspaceId: workspaceId,
            title: todo.title,
            notes: todo.notes,
            category: todo.category,
            priority: TaskPriority(rawValue: todo.priority.rawValue) ?? .medium,
            tags: todo.tags,
            isCompleted: todo.isCompleted,
            completedDate: todo.completedDate,
            createdDate: todo.createdDate,
            scheduledDate: todo.scheduledDate,
            scheduledEndDate: todo.scheduledEndDate,
            parentNoteId: nil
        )
    }
}
