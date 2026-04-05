import SwiftUI

// MARK: - Clome Corner Radius System

/// Platform-aware corner radii for the Clome ecosystem.
/// Clome desktop uses tight radii; Clome Flow iOS uses larger tap-friendly radii.
public enum ClomeCornerRadius {
    /// Sections within the Clome panel
    public static let panel: CGFloat = 6

    /// Buttons, pills, chips
    public static let button: CGFloat = {
        #if os(iOS)
        return 8
        #else
        return 4
        #endif
    }()

    /// Cards in the standalone app
    public static let card: CGFloat = {
        #if os(iOS)
        return 12
        #else
        return 8
        #endif
    }()

    /// Chat message bubbles
    public static let bubble: CGFloat = {
        #if os(iOS)
        return 14
        #else
        return 8
        #endif
    }()

    /// Input fields
    public static let input: CGFloat = {
        #if os(iOS)
        return 8
        #else
        return 4
        #endif
    }()

    /// Top-level windows (macOS only)
    public static let window: CGFloat = 14
}

// MARK: - Clome Spacing System

/// Compact spacing for Clome panels, standard spacing for iOS.
public enum ClomeSpacing {
    /// List row height
    public static let rowHeight: CGFloat = {
        #if os(iOS)
        return 40
        #else
        return 24
        #endif
    }()

    /// Card internal padding
    public static let cardPadding: CGFloat = {
        #if os(iOS)
        return 12
        #else
        return 8
        #endif
    }()

    /// Gap between major sections
    public static let sectionGap: CGFloat = {
        #if os(iOS)
        return 20
        #else
        return 12
        #endif
    }()

    /// Chat input height
    public static let chatInputHeight: CGFloat = {
        #if os(iOS)
        return 40
        #else
        return 28
        #endif
    }()

    /// Toolbar height
    public static let toolbarHeight: CGFloat = {
        #if os(iOS)
        return 44
        #else
        return 22
        #endif
    }()
}
