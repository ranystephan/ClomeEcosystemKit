import SwiftUI

// MARK: - Accent Themes

public enum ClomeAccentTheme: String, CaseIterable, Identifiable, Sendable {
    case graphite
    case indigo
    case teal
    case rose
    case sage
    case amber

    public var id: String { rawValue }

    public var lightAccent: Color {
        switch self {
        case .graphite: return Color(red: 0.180, green: 0.220, blue: 0.310)
        case .indigo:   return Color(red: 0.290, green: 0.290, blue: 0.620)
        case .teal:     return Color(red: 0.140, green: 0.420, blue: 0.420)
        case .rose:     return Color(red: 0.600, green: 0.270, blue: 0.350)
        case .sage:     return Color(red: 0.280, green: 0.420, blue: 0.340)
        case .amber:    return Color(red: 0.650, green: 0.460, blue: 0.180)
        }
    }

    public var darkAccent: Color {
        switch self {
        case .graphite: return Color(red: 0.440, green: 0.500, blue: 0.590)
        case .indigo:   return Color(red: 0.490, green: 0.490, blue: 0.820)
        case .teal:     return Color(red: 0.240, green: 0.620, blue: 0.620)
        case .rose:     return Color(red: 0.800, green: 0.470, blue: 0.550)
        case .sage:     return Color(red: 0.480, green: 0.620, blue: 0.540)
        case .amber:    return Color(red: 0.850, green: 0.660, blue: 0.380)
        }
    }

    public var displayName: String { rawValue.capitalized }
}

// MARK: - Design Mode

public enum ClomeDesignMode: String, CaseIterable, Identifiable, Sendable {
    case light
    case dark

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    public var preferredColorScheme: ColorScheme {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }
}

// MARK: - Unified Palette

/// Adaptive color palette for the Clome ecosystem.
/// The palette intentionally favors restrained surfaces and subtle borders.
public struct ClomePalette: Sendable {
    public let bg: Color
    public let surface: Color
    public let surfaceAlt: Color
    public let elevated: Color
    public let windowBackground: Color
    public let sidebarSurface: Color
    public let chromeSurface: Color
    public let chromeSurfaceAlt: Color
    public let windowTintOpacity: CGFloat
    public let bright: Color
    public let text: Color
    public let dim: Color
    public let dark: Color
    public let accent: Color
    public let red: Color
    public let yellow: Color
    public let green: Color
    public let fontDesign: Font.Design
    public let isDark: Bool

    // MARK: - Dark Palette (Clome-aligned)

    public static func dark(accent: Color = ClomeAccentTheme.graphite.darkAccent) -> ClomePalette {
        ClomePalette(
            bg: ClomeColor.base,
            surface: ClomeColor.surface,
            surfaceAlt: ClomeColor.surfaceAlt,
            elevated: ClomeColor.surfaceElevated,
            windowBackground: ClomeColor.base,
            sidebarSurface: ClomeColor.base,
            chromeSurface: ClomeColor.surface,
            chromeSurfaceAlt: ClomeColor.surfaceAlt,
            windowTintOpacity: 0.92,
            bright: ClomeColor.textPrimary,
            text: ClomeColor.textSecondary,
            dim: ClomeColor.textTertiary,
            dark: ClomeColor.border,
            accent: accent,
            red: ClomeColor.error(dark: true),
            yellow: ClomeColor.warning(dark: true),
            green: ClomeColor.success(dark: true),
            fontDesign: .default,
            isDark: true
        )
    }

    // MARK: - Light Palette

    public static func light(accent: Color = ClomeAccentTheme.graphite.lightAccent) -> ClomePalette {
        ClomePalette(
            bg: ClomeColor.lightBg,
            surface: ClomeColor.lightSurface,
            surfaceAlt: ClomeColor.lightSurfaceAlt,
            elevated: ClomeColor.lightSurfaceElevated,
            windowBackground: ClomeColor.paper,
            sidebarSurface: ClomeColor.paper,
            chromeSurface: ClomeColor.paperWarm,
            chromeSurfaceAlt: ClomeColor.lightSurfaceAlt,
            windowTintOpacity: 0.985,
            bright: ClomeColor.lightTextPrimary,
            text: ClomeColor.lightTextSecondary,
            dim: ClomeColor.lightTextTertiary,
            dark: ClomeColor.lightBorder,
            accent: accent,
            red: ClomeColor.error(dark: false),
            yellow: ClomeColor.warning(dark: false),
            green: ClomeColor.success(dark: false),
            fontDesign: .default,
            isDark: false
        )
    }

    // MARK: - Font Helpers

    public func font(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: fontDesign)
    }

    public func heading(_ size: CGFloat, weight: Font.Weight = .bold) -> Font {
        .system(size: size, weight: weight, design: fontDesign)
    }
}
