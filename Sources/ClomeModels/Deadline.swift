import Foundation

public struct Deadline: Codable, Identifiable, Sendable {
    public let id: UUID
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
