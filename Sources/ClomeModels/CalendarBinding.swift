import Foundation

// MARK: - Calendar Binding
//
// Per-workspace document describing which EventKit calendars surface in this
// workspace's Flow calendar view, and which calendar new events are written
// to by default. See `docs/flow-workspaces-spec.md` § 3.3.
//
// Stored at:  workspaces/{id}/calendarBinding
//
// EventKit calendars themselves are NOT mirrored to Firestore — only the
// per-workspace selection of which `EKCalendar.calendarIdentifier`s belong
// in scope. iCloud Calendar handles the actual cross-device event sync.

public struct CalendarBinding: Codable, Sendable {
    /// `EKCalendar.calendarIdentifier` values explicitly included in this
    /// workspace. Empty when `includeAllCalendars == true`.
    public var calendarIdentifiers: [String]

    /// Where Flow-created events are written. Nil falls back to
    /// `EKEventStore.defaultCalendarForNewEvents`.
    public var defaultCalendarIdentifier: String?

    /// Convenience flag for the Personal workspace. When true,
    /// `calendarIdentifiers` is ignored and every available calendar is
    /// shown.
    public var includeAllCalendars: Bool

    /// Optional tag (e.g. `[workspace:acme]`) injected into event titles by
    /// the Mac app when creating events from a Clome workspace context. Lets
    /// a workspace surface events even when those events live in a shared
    /// or family calendar that isn't bound to the workspace.
    public var tagInjection: String?

    public init(
        calendarIdentifiers: [String] = [],
        defaultCalendarIdentifier: String? = nil,
        includeAllCalendars: Bool = false,
        tagInjection: String? = nil
    ) {
        self.calendarIdentifiers = calendarIdentifiers
        self.defaultCalendarIdentifier = defaultCalendarIdentifier
        self.includeAllCalendars = includeAllCalendars
        self.tagInjection = tagInjection
    }

    /// Default binding for the Personal workspace: every calendar is in
    /// scope, no tag injection, no override default calendar.
    public static let personalDefault = CalendarBinding(
        calendarIdentifiers: [],
        defaultCalendarIdentifier: nil,
        includeAllCalendars: true,
        tagInjection: nil
    )

    /// Returns true if the given EventKit calendar identifier should appear
    /// in this workspace's Flow calendar view.
    public func includes(calendarIdentifier id: String) -> Bool {
        if includeAllCalendars { return true }
        return calendarIdentifiers.contains(id)
    }
}
