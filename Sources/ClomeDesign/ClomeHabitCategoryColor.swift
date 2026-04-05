import SwiftUI
import ClomeModels

/// Color extension for HabitCategory — lives in ClomeDesign since it depends on SwiftUI.
extension HabitCategory {
    public var color: Color {
        switch self {
        case .sleep: return .clomeSleep
        case .meal: return .clomeMeal
        case .exercise: return .clomeExercise
        case .study: return .clomeStudy
        case .meeting: return .clomeMeeting
        case .chores: return .clomeChores
        case .general: return Color(red: 0.482, green: 0.498, blue: 0.588)
        case .research: return .clomeResearch
        case .personalStudy: return .clomePersonalStudy
        case .reading: return .clomeReading
        case .socialEvent: return .clomeSocial
        case .selfCare: return .clomeSelfCare
        case .commute: return .clomeCommute
        case .creative: return .clomeCreative
        case .work: return .clomeWork
        case .entertainment: return .clomeEntertainment
        case .lecture: return .clomeLecture
        }
    }
}

/// Color extension for PlanCardType.
extension PlanCardType {
    public var tintColor: Color {
        switch self {
        case .schedule:      return ClomeColor.success(dark: true)
        case .reschedule:    return .orange
        case .delete:        return ClomeColor.error(dark: true)
        case .reminder:      return ClomeColor.info(dark: true)
        case .profileUpdate: return .purple
        case .deadline:      return ClomeColor.error(dark: true)
        case .todo:          return .indigo
        }
    }
}

/// Color extension for NoteCategory.
extension NoteCategory {
    public var color: Color {
        switch self {
        case .idea: return .clomeIdea
        case .task: return .clomeTask
        case .reminder: return .clomeReminder
        case .goal: return .clomeGoal
        case .journal: return .clomeJournal
        case .reference: return .clomeReference
        }
    }
}
