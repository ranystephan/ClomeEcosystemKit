import Foundation

public enum HabitCategory: String, Codable, CaseIterable, Hashable, Sendable {
    case sleep
    case meal
    case exercise
    case study
    case meeting
    case chores
    case general
    case research
    case personalStudy
    case reading
    case socialEvent
    case selfCare
    case commute
    case creative
    case work
    case entertainment
    case lecture

    // MARK: - Backwards Compatibility

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        switch raw {
        case "gym": self = .exercise
        case "errand": self = .chores
        case "class", "course", "seminar", "tutorial", "recitation", "lab": self = .lecture
        default:
            guard let value = HabitCategory(rawValue: raw) else {
                self = .general
                return
            }
            self = value
        }
    }

    // MARK: - Reschedulability

    public var isReschedulable: Bool {
        switch self {
        case .lecture, .meeting, .meal, .sleep, .commute, .socialEvent:
            return false
        case .exercise, .study, .research, .personalStudy, .reading,
             .chores, .creative, .work, .selfCare, .entertainment, .general:
            return true
        }
    }

    // MARK: - Display

    public var displayName: String {
        switch self {
        case .personalStudy: return "Personal Study"
        case .socialEvent: return "Social Event"
        case .selfCare: return "Self Care"
        case .lecture: return "Class"
        default: return rawValue.capitalized
        }
    }

    public var icon: String {
        switch self {
        case .sleep: return "moon.fill"
        case .meal: return "fork.knife"
        case .exercise: return "figure.run"
        case .study: return "book.fill"
        case .meeting: return "person.2.fill"
        case .chores: return "house.fill"
        case .general: return "circle.fill"
        case .research: return "magnifyingglass"
        case .personalStudy: return "laptopcomputer"
        case .reading: return "book.closed.fill"
        case .socialEvent: return "person.3.fill"
        case .selfCare: return "heart.fill"
        case .commute: return "car.fill"
        case .creative: return "paintbrush.fill"
        case .work: return "briefcase.fill"
        case .entertainment: return "gamecontroller.fill"
        case .lecture: return "graduationcap.fill"
        }
    }
}
