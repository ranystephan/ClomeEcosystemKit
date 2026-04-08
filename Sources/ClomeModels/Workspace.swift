import Foundation

// MARK: - Workspace Color Key
//
// Workspaces carry a `colorKey` rather than a raw hex string so that each
// platform can resolve the key against its own palette tokens (Mac uses
// FlowTokens, iOS uses PreefloColorSystem). The set is intentionally small —
// adding a new color is a coordinated change to both palettes.

public enum WorkspaceColorKey: String, Codable, CaseIterable, Sendable {
    case teal
    case coral
    case indigo
    case sage
    case amber
    case rose
    case graphite
}

// MARK: - Workspace
//
// The top-level container for all Flow content. Every NoteEntry, TaskItem,
// and Deadline belongs to exactly one workspace. See
// `docs/flow-workspaces-spec.md` for the full schema and Firestore paths.
//
// Stored at:  workspaces/{id}                  (top-level, not user-nested)

public struct FlowWorkspace: Codable, Identifiable, Sendable, Hashable {
    public let id: String
    public var name: String
    public var slug: String
    public var icon: String
    public var colorKey: WorkspaceColorKey
    public let ownerUid: String
    public let createdAt: Date
    public var updatedAt: Date
    public let isPersonal: Bool
    public var isArchived: Bool
    public var sortOrder: Int

    public init(
        id: String,
        name: String,
        slug: String,
        icon: String = "folder",
        colorKey: WorkspaceColorKey = .teal,
        ownerUid: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        isPersonal: Bool = false,
        isArchived: Bool = false,
        sortOrder: Int = 0
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.icon = icon
        self.colorKey = colorKey
        self.ownerUid = ownerUid
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isPersonal = isPersonal
        self.isArchived = isArchived
        self.sortOrder = sortOrder
    }

    // MARK: - Personal workspace factory

    /// Deterministic ID for the user's personal workspace. Both platforms use
    /// the same recipe so a race between two devices migrating at the same
    /// time still resolves to the same document.
    public static func personalID(for uid: String) -> String {
        "personal-\(uid)"
    }

    /// Build the canonical Personal workspace for a user. Used by the
    /// migration step on first launch.
    public static func makePersonal(uid: String, name: String = "Personal") -> FlowWorkspace {
        FlowWorkspace(
            id: personalID(for: uid),
            name: name,
            slug: "personal",
            icon: "person.crop.circle",
            colorKey: .graphite,
            ownerUid: uid,
            isPersonal: true,
            sortOrder: 0
        )
    }

    /// Slugify a free-form workspace name for use in deep links.
    /// Lowercases, collapses non-alphanumerics to hyphens, trims edges.
    public static func slugify(_ name: String) -> String {
        let lowered = name.lowercased()
        let allowed = Set("abcdefghijklmnopqrstuvwxyz0123456789-")
        var result = ""
        var lastWasDash = false
        for char in lowered {
            if allowed.contains(char) && char != "-" {
                result.append(char)
                lastWasDash = false
            } else if !lastWasDash && !result.isEmpty {
                result.append("-")
                lastWasDash = true
            }
        }
        while result.hasSuffix("-") { result.removeLast() }
        return result.isEmpty ? "workspace" : result
    }
}
