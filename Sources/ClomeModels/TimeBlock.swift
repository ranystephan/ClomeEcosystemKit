import Foundation

public struct TimeBlock: Identifiable, Codable, Sendable {
    public let id: UUID
    public let start: Date
    public let end: Date
    public var isFree: Bool
    public var eventTitle: String?
    public var flexibility: ScheduleFlexibility?
    public var priority: SchedulePriority?
    public var category: HabitCategory?

    public init(
        id: UUID = UUID(),
        start: Date,
        end: Date,
        isFree: Bool = true,
        eventTitle: String? = nil,
        flexibility: ScheduleFlexibility? = nil,
        priority: SchedulePriority? = nil,
        category: HabitCategory? = nil
    ) {
        self.id = id
        self.start = start
        self.end = end
        self.isFree = isFree
        self.eventTitle = eventTitle
        self.flexibility = flexibility
        self.priority = priority
        self.category = category
    }

    public var durationMinutes: Int {
        Int(end.timeIntervalSince(start) / 60)
    }
}
