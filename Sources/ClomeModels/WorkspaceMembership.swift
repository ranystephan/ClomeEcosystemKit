import Foundation

// MARK: - Workspace Membership
//
// Per-user index of which workspaces the user owns. Single document per user
// at users/{uid}/membership. See `docs/flow-workspaces-spec.md` § 3.2.
//
// In v1 this is just "the workspaces I own" because we're solo-only. The
// schema is shaped this way so a future collaborative phase can add
// per-membership state (notification policy, role) without changing where
// the document lives.

public struct WorkspaceMembership: Codable, Sendable {
    public var workspaceIds: [String]
    public var lastOpenedWorkspaceId: String?
    public var pinnedOrder: [String]
    public var didMigrate: Bool

    public init(
        workspaceIds: [String] = [],
        lastOpenedWorkspaceId: String? = nil,
        pinnedOrder: [String] = [],
        didMigrate: Bool = false
    ) {
        self.workspaceIds = workspaceIds
        self.lastOpenedWorkspaceId = lastOpenedWorkspaceId
        self.pinnedOrder = pinnedOrder
        self.didMigrate = didMigrate
    }

    /// Returns the user's workspaces in display order. Personal (the workspace
    /// matching `personalID`) is forced to index 0 regardless of `pinnedOrder`.
    /// Unknown IDs in `pinnedOrder` are ignored. Workspaces present in
    /// `workspaceIds` but not in `pinnedOrder` are appended in their
    /// `workspaceIds` order so newly synced workspaces from other devices
    /// don't disappear from the switcher.
    public func orderedWorkspaceIDs(personalID: String) -> [String] {
        var result: [String] = []
        var seen = Set<String>()

        // Personal is always rank 0.
        if workspaceIds.contains(personalID) {
            result.append(personalID)
            seen.insert(personalID)
        }

        // Then user-pinned order.
        for id in pinnedOrder where workspaceIds.contains(id) && !seen.contains(id) {
            result.append(id)
            seen.insert(id)
        }

        // Then anything else not yet in the list.
        for id in workspaceIds where !seen.contains(id) {
            result.append(id)
            seen.insert(id)
        }

        return result
    }
}
