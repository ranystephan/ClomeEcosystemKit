import Foundation

public struct Deadline: Codable, Identifiable, Sendable {
    public let id: UUID
    /// The workspace this deadline belongs to. Optional only during the
    /// migration window — nil values are coerced to the user's Personal
    /// workspace ID by the sync layer at read time.
    /// See `docs/flow-workspaces-spec.md` § 3.5.
    public var workspaceId: String?
    public var title: String
    public var dueDate: Date
    public var category: HabitCategory
    public var estimatedPrepHours: Double?
    public var linkedEventTitles: [String]
    public var isCompleted: Bool
    public let createdDate: Date
    public var projectTag: String?

    public init(
        id: UUID = UUID(),
        workspaceId: String? = nil,
        title: String,
        dueDate: Date,
        category: HabitCategory = .general,
        estimatedPrepHours: Double? = nil,
        linkedEventTitles: [String] = [],
        isCompleted: Bool = false,
        createdDate: Date = Date(),
        projectTag: String? = nil
    ) {
        self.id = id
        self.workspaceId = workspaceId
        self.title = title
        self.dueDate = dueDate
        self.category = category
        self.estimatedPrepHours = estimatedPrepHours
        self.linkedEventTitles = linkedEventTitles
        self.isCompleted = isCompleted
        self.createdDate = createdDate
        self.projectTag = projectTag
    }

    public var hoursUntilDue: Double {
        dueDate.timeIntervalSince(Date()) / 3600
    }

    public var isPastDue: Bool {
        dueDate < Date()
    }
}
