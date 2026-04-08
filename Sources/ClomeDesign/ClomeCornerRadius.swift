import SwiftUI

// MARK: - Clome Corner Radius System

/// Platform-aware corner radii for the Clome ecosystem.
/// The shell now favors slightly roomier Apple-like corners on macOS too.
public enum ClomeCornerRadius {
    /// Sections within the Clome panel
    public static let panel: CGFloat = 10

    /// Buttons, pills, chips
    public static let button: CGFloat = {
        #if os(iOS)
        return 12
        #else
        return 10
        #endif
    }()

    /// Cards in the standalone app
    public static let card: CGFloat = {
        #if os(iOS)
        return 16
        #else
        return 12
        #endif
    }()

    /// Chat message bubbles
    public static let bubble: CGFloat = {
        #if os(iOS)
        return 14
        #else
        return 12
        #endif
    }()

    /// Input fields
    public static let input: CGFloat = {
        #if os(iOS)
        return 12
        #else
        return 10
        #endif
    }()

    /// Top-level windows (macOS only)
    public static let window: CGFloat = 18
}

// MARK: - Clome Spacing System

/// Shared spacing tuned toward calmer section rhythm.
public enum ClomeSpacing {
    /// List row height
    public static let rowHeight: CGFloat = {
        #if os(iOS)
        return 40
        #else
        return 28
        #endif
    }()

    /// Card internal padding
    public static let cardPadding: CGFloat = {
        #if os(iOS)
        return 16
        #else
        return 12
        #endif
    }()

    /// Gap between major sections
    public static let sectionGap: CGFloat = {
        #if os(iOS)
        return 24
        #else
        return 16
        #endif
    }()

    /// Chat input height
    public static let chatInputHeight: CGFloat = {
        #if os(iOS)
        return 40
        #else
        return 36
        #endif
    }()

    /// Toolbar height
    public static let toolbarHeight: CGFloat = {
        #if os(iOS)
        return 44
        #else
        return 40
        #endif
    }()
}
