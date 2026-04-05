import Foundation

// MARK: - Plan Card Types

public enum PlanCardType: String, Codable, Sendable {
    case schedule
    case reschedule
    case delete
    case reminder
    case profileUpdate
    case deadline
    case todo

    public var displayLabel: String {
        switch self {
        case .schedule:      return "Schedule"
        case .reschedule:    return "Reschedule"
        case .delete:        return "Delete"
        case .reminder:      return "Reminder"
        case .profileUpdate: return "Update"
        case .deadline:      return "Deadline"
        case .todo:          return "Todo"
        }
    }

    public var defaultIcon: String {
        switch self {
        case .schedule:      return "calendar.badge.plus"
        case .reschedule:    return "arrow.triangle.2.circlepath"
        case .delete:        return "trash"
        case .reminder:      return "bell"
        case .profileUpdate: return "person.fill.checkmark"
        case .deadline:      return "flag.fill"
        case .todo:          return "checklist"
        }
    }
}

public struct PlanCard: Identifiable, Codable, Sendable {
    public let id: UUID
    public let actionType: PlanCardType
    public var title: String
    public var subtitle: String?
    public let icon: String?
    public var proposedDate: Date?
    public var duration: Int?
    public var actionIndex: Int?
    public var eventSubIndex: Int?

    public init(
        id: UUID = UUID(),
        actionType: PlanCardType,
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        proposedDate: Date? = nil,
        duration: Int? = nil,
        actionIndex: Int? = nil,
        eventSubIndex: Int? = nil
    ) {
        self.id = id
        self.actionType = actionType
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.proposedDate = proposedDate
        self.duration = duration
        self.actionIndex = actionIndex
        self.eventSubIndex = eventSubIndex
    }
}
