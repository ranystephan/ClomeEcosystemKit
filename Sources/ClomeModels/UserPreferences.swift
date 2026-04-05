import Foundation

public struct MealTimes: Codable, Equatable, Sendable {
    public var breakfast: String  // "HH:mm"
    public var lunch: String
    public var dinner: String
    public var durationMinutes: Int

    public static let `default` = MealTimes(
        breakfast: "08:00",
        lunch: "12:30",
        dinner: "19:00",
        durationMinutes: 30
    )

    public init(breakfast: String, lunch: String, dinner: String, durationMinutes: Int) {
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.durationMinutes = durationMinutes
    }
}

public struct RejectionEntry: Codable, Equatable, Sendable {
    public let category: String
    public let timeOfDay: String
    public let date: Date

    public init(category: String, timeOfDay: String, date: Date) {
        self.category = category
        self.timeOfDay = timeOfDay
        self.date = date
    }
}

public struct UserPreferences: Codable, Equatable, Sendable {
    public var defaultWakeTime: String
    public var defaultSleepDuration: Double
    public var mealTimes: MealTimes
    public var bufferMinutes: Int
    public var preferredWorkSessionMinutes: Int
    public var gymDuration: Int

    // User Identity
    public var userName: String
    public var occupation: String
    public var lifestyleNotes: String

    // Hours & Preferences
    public var businessHoursStart: String
    public var businessHoursEnd: String
    public var errandHoursStart: String
    public var errandHoursEnd: String
    public var wakingHoursEnd: String
    public var workHoursStart: String
    public var workHoursEnd: String
    public var gymPreference: String
    public var studyPreference: String
    public var preferredGymDays: [Int]
    public var commuteDefaultMinutes: Int

    // Auto-Reschedule
    public var autoRescheduleEnabled: Bool

    // Calendars
    public var hiddenCalendarIDs: [String]
    public var aiExcludedCalendarIDs: [String]

    // Notifications
    public var eventNotificationsEnabled: Bool
    public var eventNotificationMinutes: Int
    public var dailyReminderEnabled: Bool
    public var dailyReminderTime: String

    // Smart Notifications
    public var morningBriefingEnabled: Bool
    public var deadlineWarningsEnabled: Bool
    public var streakAtRiskEnabled: Bool

    // Rejection History
    public var rejectionHistory: [RejectionEntry]

    public init(
        defaultWakeTime: String = "08:00",
        defaultSleepDuration: Double = 7.5,
        mealTimes: MealTimes = .default,
        bufferMinutes: Int = 15,
        preferredWorkSessionMinutes: Int = 90,
        gymDuration: Int = 60,
        userName: String = "",
        occupation: String = "",
        lifestyleNotes: String = "",
        businessHoursStart: String = "09:00",
        businessHoursEnd: String = "17:00",
        errandHoursStart: String = "10:00",
        errandHoursEnd: String = "18:00",
        wakingHoursEnd: String = "22:00",
        workHoursStart: String = "09:00",
        workHoursEnd: String = "17:00",
        gymPreference: String = "any",
        studyPreference: String = "morning",
        preferredGymDays: [Int] = [],
        commuteDefaultMinutes: Int = 30,
        autoRescheduleEnabled: Bool = true,
        hiddenCalendarIDs: [String] = [],
        aiExcludedCalendarIDs: [String] = [],
        eventNotificationsEnabled: Bool = true,
        eventNotificationMinutes: Int = 10,
        dailyReminderEnabled: Bool = true,
        dailyReminderTime: String = "09:00",
        morningBriefingEnabled: Bool = true,
        deadlineWarningsEnabled: Bool = true,
        streakAtRiskEnabled: Bool = true,
        rejectionHistory: [RejectionEntry] = []
    ) {
        self.defaultWakeTime = defaultWakeTime
        self.defaultSleepDuration = defaultSleepDuration
        self.mealTimes = mealTimes
        self.bufferMinutes = bufferMinutes
        self.preferredWorkSessionMinutes = preferredWorkSessionMinutes
        self.gymDuration = gymDuration
        self.userName = userName
        self.occupation = occupation
        self.lifestyleNotes = lifestyleNotes
        self.businessHoursStart = businessHoursStart
        self.businessHoursEnd = businessHoursEnd
        self.errandHoursStart = errandHoursStart
        self.errandHoursEnd = errandHoursEnd
        self.wakingHoursEnd = wakingHoursEnd
        self.workHoursStart = workHoursStart
        self.workHoursEnd = workHoursEnd
        self.gymPreference = gymPreference
        self.studyPreference = studyPreference
        self.preferredGymDays = preferredGymDays
        self.commuteDefaultMinutes = commuteDefaultMinutes
        self.autoRescheduleEnabled = autoRescheduleEnabled
        self.hiddenCalendarIDs = hiddenCalendarIDs
        self.aiExcludedCalendarIDs = aiExcludedCalendarIDs
        self.eventNotificationsEnabled = eventNotificationsEnabled
        self.eventNotificationMinutes = eventNotificationMinutes
        self.dailyReminderEnabled = dailyReminderEnabled
        self.dailyReminderTime = dailyReminderTime
        self.morningBriefingEnabled = morningBriefingEnabled
        self.deadlineWarningsEnabled = deadlineWarningsEnabled
        self.streakAtRiskEnabled = streakAtRiskEnabled
        self.rejectionHistory = rejectionHistory
    }

    public mutating func logRejection(category: String, timeOfDay: String) {
        let entry = RejectionEntry(category: category, timeOfDay: timeOfDay, date: Date())
        rejectionHistory.append(entry)
        if rejectionHistory.count > 50 {
            rejectionHistory = Array(rejectionHistory.suffix(50))
        }
    }

    public func rejectionSummary() -> String {
        let cutoff = Calendar.current.date(byAdding: .day, value: -14, to: Date()) ?? Date()
        let recent = rejectionHistory.filter { $0.date >= cutoff }
        guard !recent.isEmpty else { return "" }

        var counts: [String: Int] = [:]
        for r in recent {
            let key = "\(r.timeOfDay) \(r.category)"
            counts[key, default: 0] += 1
        }

        let lines = counts
            .sorted { $0.value > $1.value }
            .prefix(5)
            .map { "- Rejected \($0.key) proposals \($0.value)x recently" }

        guard !lines.isEmpty else { return "" }
        return "REJECTION PATTERNS:\n" + lines.joined(separator: "\n")
    }
}
