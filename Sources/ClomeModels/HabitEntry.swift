import Foundation

public struct HabitEntry: Codable, Identifiable, Sendable {
    public let id: UUID
    public let eventTitle: String
    public var category: HabitCategory
    public let scheduledDate: Date
    public let scheduledEndDate: Date
    public var completedDate: Date?
    public var wasCompleted: Bool

    public init(
        id: UUID = UUID(),
        eventTitle: String,
        category: HabitCategory,
        scheduledDate: Date,
        scheduledEndDate: Date,
        completedDate: Date? = nil,
        wasCompleted: Bool = false
    ) {
        self.id = id
        self.eventTitle = eventTitle
        self.category = category
        self.scheduledDate = scheduledDate
        self.scheduledEndDate = scheduledEndDate
        self.completedDate = completedDate
        self.wasCompleted = wasCompleted
    }
}
