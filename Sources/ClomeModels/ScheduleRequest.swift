import Foundation

public enum SchedulePriority: String, Codable, Sendable {
    case high
    case medium
    case low
}

public enum ScheduleFlexibility: String, Codable, Sendable {
    case fixed
    case flexible
    case movable
}

public enum ScheduleRequestType: String, Codable, Sendable {
    case sleepSchedule
    case singleTask
    case recurringEvent
    case taskDecomposition
    case mealSchedule
    case gymSession
    case errand
    case freeformEvent
    case clarification
}

public struct TimeRange: Codable, Sendable {
    public let start: String  // "HH:mm"
    public let end: String    // "HH:mm"

    public init(start: String, end: String) {
        self.start = start
        self.end = end
    }
}

public struct Recurrence: Codable, Sendable {
    public let frequency: RecurrenceFrequency
    public let interval: Int
    public let count: Int?
    public let daysOfWeek: [Int]?

    public init(frequency: RecurrenceFrequency, interval: Int, count: Int?, daysOfWeek: [Int]?) {
        self.frequency = frequency
        self.interval = interval
        self.count = count
        self.daysOfWeek = daysOfWeek
    }
}

public enum RecurrenceFrequency: String, Codable, Sendable {
    case daily
    case weekly
    case biweekly
    case monthly
}

public struct DayOverride: Codable, Sendable {
    public let dayOfWeek: Int
    public let wakeTime: String?
    public let sleepDuration: Int?

    public init(dayOfWeek: Int, wakeTime: String? = nil, sleepDuration: Int? = nil) {
        self.dayOfWeek = dayOfWeek
        self.wakeTime = wakeTime
        self.sleepDuration = sleepDuration
    }
}

public struct ScheduleRequest: Codable, Sendable {
    public let type: ScheduleRequestType
    public let title: String
    public let duration: Int?
    public let totalDuration: Int?
    public let deadline: String?
    public let preferredTimeRange: TimeRange?
    public let recurrence: Recurrence?
    public let location: String?
    public let constraints: [String]?
    public let daysOfWeek: [Int]?
    public let wakeTime: String?
    public let sleepDuration: Int?
    public let dayOverrides: [DayOverride]?
    public let clarificationQuestion: String?
    public let sessionDuration: Int?
    public let isExactTime: Bool
    public let isPastEvent: Bool
    public let priority: SchedulePriority?
    public let earliestDate: String?
    public let latestDate: String?
    public let earliestTime: String?
    public let latestTime: String?
    public let flexibility: ScheduleFlexibility?
    public let occurrenceCount: Int?
    public let skipLifestyleFilters: Bool

    public init(
        type: ScheduleRequestType,
        title: String,
        duration: Int? = nil,
        totalDuration: Int? = nil,
        deadline: String? = nil,
        preferredTimeRange: TimeRange? = nil,
        recurrence: Recurrence? = nil,
        location: String? = nil,
        constraints: [String]? = nil,
        daysOfWeek: [Int]? = nil,
        wakeTime: String? = nil,
        sleepDuration: Int? = nil,
        dayOverrides: [DayOverride]? = nil,
        clarificationQuestion: String? = nil,
        sessionDuration: Int? = nil,
        isExactTime: Bool = false,
        isPastEvent: Bool = false,
        priority: SchedulePriority? = nil,
        earliestDate: String? = nil,
        latestDate: String? = nil,
        earliestTime: String? = nil,
        latestTime: String? = nil,
        flexibility: ScheduleFlexibility? = nil,
        occurrenceCount: Int? = nil,
        skipLifestyleFilters: Bool = false
    ) {
        self.type = type
        self.title = title
        self.duration = duration
        self.totalDuration = totalDuration
        self.deadline = deadline
        self.preferredTimeRange = preferredTimeRange
        self.recurrence = recurrence
        self.location = location
        self.constraints = constraints
        self.daysOfWeek = daysOfWeek
        self.wakeTime = wakeTime
        self.sleepDuration = sleepDuration
        self.dayOverrides = dayOverrides
        self.clarificationQuestion = clarificationQuestion
        self.sessionDuration = sessionDuration
        self.isExactTime = isExactTime
        self.isPastEvent = isPastEvent
        self.priority = priority
        self.earliestDate = earliestDate
        self.latestDate = latestDate
        self.earliestTime = earliestTime
        self.latestTime = latestTime
        self.flexibility = flexibility
        self.occurrenceCount = occurrenceCount
        self.skipLifestyleFilters = skipLifestyleFilters
    }

    private enum CodingKeys: String, CodingKey {
        case type, title, duration, totalDuration, deadline, preferredTimeRange
        case recurrence, location, constraints, daysOfWeek, wakeTime, sleepDuration
        case dayOverrides, clarificationQuestion, sessionDuration, isExactTime
        case isPastEvent, priority, earliestDate, latestDate, earliestTime, latestTime
        case flexibility, occurrenceCount, skipLifestyleFilters
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(ScheduleRequestType.self, forKey: .type)
        title = try container.decode(String.self, forKey: .title)
        duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        totalDuration = try container.decodeIfPresent(Int.self, forKey: .totalDuration)
        deadline = try container.decodeIfPresent(String.self, forKey: .deadline)
        preferredTimeRange = try container.decodeIfPresent(TimeRange.self, forKey: .preferredTimeRange)
        recurrence = try container.decodeIfPresent(Recurrence.self, forKey: .recurrence)
        location = try container.decodeIfPresent(String.self, forKey: .location)
        constraints = try container.decodeIfPresent([String].self, forKey: .constraints)
        daysOfWeek = try container.decodeIfPresent([Int].self, forKey: .daysOfWeek)
        wakeTime = try container.decodeIfPresent(String.self, forKey: .wakeTime)
        sleepDuration = try container.decodeIfPresent(Int.self, forKey: .sleepDuration)
        dayOverrides = try container.decodeIfPresent([DayOverride].self, forKey: .dayOverrides)
        clarificationQuestion = try container.decodeIfPresent(String.self, forKey: .clarificationQuestion)
        sessionDuration = try container.decodeIfPresent(Int.self, forKey: .sessionDuration)
        isExactTime = try container.decodeIfPresent(Bool.self, forKey: .isExactTime) ?? false
        isPastEvent = try container.decodeIfPresent(Bool.self, forKey: .isPastEvent) ?? false
        priority = try container.decodeIfPresent(SchedulePriority.self, forKey: .priority)
        earliestDate = try container.decodeIfPresent(String.self, forKey: .earliestDate)
        latestDate = try container.decodeIfPresent(String.self, forKey: .latestDate)
        earliestTime = try container.decodeIfPresent(String.self, forKey: .earliestTime)
        latestTime = try container.decodeIfPresent(String.self, forKey: .latestTime)
        flexibility = try container.decodeIfPresent(ScheduleFlexibility.self, forKey: .flexibility)
        occurrenceCount = try container.decodeIfPresent(Int.self, forKey: .occurrenceCount)
        skipLifestyleFilters = try container.decodeIfPresent(Bool.self, forKey: .skipLifestyleFilters) ?? false
    }

    // MARK: - Mutation Helpers

    public func relaxed(dropConstraints: Bool = false, dropTimeRange: Bool = false, dropDateWindow: Bool = false, skipLifestyle: Bool = false) -> ScheduleRequest {
        ScheduleRequest(
            type: type, title: title, duration: duration, totalDuration: totalDuration,
            deadline: deadline,
            preferredTimeRange: dropTimeRange ? nil : preferredTimeRange,
            recurrence: recurrence, location: location,
            constraints: dropConstraints ? nil : constraints,
            daysOfWeek: daysOfWeek, wakeTime: wakeTime, sleepDuration: sleepDuration,
            dayOverrides: dayOverrides, clarificationQuestion: clarificationQuestion,
            sessionDuration: sessionDuration,
            isExactTime: dropTimeRange ? false : isExactTime,
            isPastEvent: isPastEvent, priority: priority,
            earliestDate: dropDateWindow ? nil : earliestDate,
            latestDate: dropDateWindow ? nil : latestDate,
            earliestTime: dropTimeRange ? nil : earliestTime,
            latestTime: dropTimeRange ? nil : latestTime,
            flexibility: flexibility, occurrenceCount: occurrenceCount,
            skipLifestyleFilters: skipLifestyle || skipLifestyleFilters
        )
    }

    /// Parse "HH:mm" to total minutes since midnight
    public static func timeToMinutes(_ time: String) -> Int? {
        let parts = time.split(separator: ":").compactMap { Int($0) }
        guard parts.count == 2, parts[0] >= 0, parts[0] <= 23, parts[1] >= 0, parts[1] <= 59 else {
            return nil
        }
        return parts[0] * 60 + parts[1]
    }

    /// ISO weekday: 1=Mon, 2=Tue, ..., 7=Sun
    public static func isoWeekday(for date: Date) -> Int {
        let weekday = Calendar.current.component(.weekday, from: date)
        return weekday == 1 ? 7 : weekday - 1
    }
}
