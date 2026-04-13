import SwiftUI

// MARK: - Clome Unified Color System

/// Unified color system for the Clome ecosystem.
/// Dark mode and light mode intentionally mirror the calmer Clome Flow palette:
/// restrained neutrals, thin borders, and one structural accent.
public enum ClomeColor {

    // MARK: - Website Reference Colors

    public static let paper = Color(red: 0.957, green: 0.945, blue: 0.918)
    public static let paperWarm = Color(red: 0.937, green: 0.922, blue: 0.886)
    public static let ink = Color(red: 0.055, green: 0.063, blue: 0.078)
    public static let inkSecondary = Color(red: 0.290, green: 0.310, blue: 0.341)
    public static let inkTertiary = Color(red: 0.541, green: 0.565, blue: 0.604)
    public static let rule = ink.opacity(0.09)
    public static let ruleStrong = ink.opacity(0.18)

    // MARK: - Base (Dark)

    /// Deep ink shell derived from the site palette.
    public static let base = Color(red: 0.071, green: 0.082, blue: 0.106)

    /// Layered dark surfaces with slightly warmer contrast than the old theme.
    public static let surface = Color(red: 0.102, green: 0.118, blue: 0.153)
    public static let surfaceAlt = Color(red: 0.133, green: 0.153, blue: 0.196)
    public static let surfaceElevated = Color(red: 0.169, green: 0.188, blue: 0.235)
    public static let surfaceHighest = Color(red: 0.224, green: 0.243, blue: 0.302)

    /// Borders and dividers
    public static let border = Color.white.opacity(0.10)
    public static let borderSubtle = Color.white.opacity(0.07)
    public static let borderStrong = Color.white.opacity(0.18)

    // MARK: - Text Hierarchy (Dark)

    public static let textPrimary = Color(red: 0.949, green: 0.953, blue: 0.965)
    public static let textSecondary = Color(red: 0.753, green: 0.773, blue: 0.816)
    public static let textTertiary = Color(red: 0.588, green: 0.608, blue: 0.655)
    public static let textMuted = Color(red: 0.447, green: 0.467, blue: 0.514)

    // MARK: - Light Mode Neutrals

    public static let lightBg = paper
    public static let lightSurface = Color(red: 0.952, green: 0.937, blue: 0.902)
    public static let lightSurfaceAlt = Color(red: 0.980, green: 0.972, blue: 0.952)
    public static let lightSurfaceElevated = Color(red: 0.992, green: 0.988, blue: 0.980)
    public static let lightBorder = rule
    public static let lightTextPrimary = ink
    public static let lightTextSecondary = inkSecondary
    public static let lightTextTertiary = inkTertiary

    // MARK: - Accent

    /// Structural accent aligned with the website's editorial blue.
    public static let accent = Color(red: 0.118, green: 0.290, blue: 0.659)
    public static let accentSoft = accent.opacity(0.08)

    // MARK: - Semantic

    public static func success(dark: Bool) -> Color {
        dark ? Color(red: 0.431, green: 0.765, blue: 0.627) : Color(red: 0.227, green: 0.561, blue: 0.443)
    }

    public static func warning(dark: Bool) -> Color {
        dark ? Color(red: 0.949, green: 0.753, blue: 0.447) : Color(red: 0.831, green: 0.533, blue: 0.243)
    }

    public static func error(dark: Bool) -> Color {
        dark ? Color(red: 0.925, green: 0.549, blue: 0.529) : Color(red: 0.753, green: 0.310, blue: 0.310)
    }

    public static func info(dark: Bool) -> Color {
        dark ? Color(red: 0.502, green: 0.655, blue: 0.902) : Color(red: 0.180, green: 0.392, blue: 0.710)
    }

    // MARK: - Gold (Rewards/XP)

    public static let gold = Color(red: 0.914, green: 0.769, blue: 0.416)
    public static let goldLight = Color(red: 0.973, green: 0.878, blue: 0.620)
}

// MARK: - Category Colors

/// Activity/habit category colors shared across the ecosystem.
/// High-contrast palette with good perceptual separation.
extension Color {
    public static let clomeSleep = Color(red: 0.420, green: 0.380, blue: 0.700)
    public static let clomeMeal = Color(red: 0.760, green: 0.500, blue: 0.190)
    public static let clomeExercise = Color(red: 0.180, green: 0.560, blue: 0.380)
    public static let clomeStudy = Color(red: 0.235, green: 0.450, blue: 0.720)
    public static let clomeMeeting = Color(red: 0.145, green: 0.555, blue: 0.540)
    public static let clomeChores = Color(red: 0.560, green: 0.500, blue: 0.380)
    public static let clomeResearch = Color(red: 0.345, green: 0.475, blue: 0.640)
    public static let clomePersonalStudy = Color(red: 0.490, green: 0.350, blue: 0.640)
    public static let clomeReading = Color(red: 0.575, green: 0.420, blue: 0.260)
    public static let clomeSocial = Color(red: 0.730, green: 0.360, blue: 0.475)
    public static let clomeSelfCare = Color(red: 0.340, green: 0.580, blue: 0.530)
    public static let clomeCommute = Color(red: 0.420, green: 0.460, blue: 0.545)
    public static let clomeCreative = Color(red: 0.720, green: 0.435, blue: 0.220)
    public static let clomeWork = Color(red: 0.290, green: 0.410, blue: 0.590)
    public static let clomeEntertainment = Color(red: 0.620, green: 0.315, blue: 0.535)
    public static let clomeLecture = Color(red: 0.330, green: 0.490, blue: 0.665)
}

// MARK: - Note Category Colors

extension Color {
    public static let clomeIdea = Color(red: 0.820, green: 0.680, blue: 0.310)
    public static let clomeTask = Color(red: 0.320, green: 0.490, blue: 0.700)
    public static let clomeReminder = Color(red: 0.800, green: 0.530, blue: 0.250)
    public static let clomeGoal = Color(red: 0.240, green: 0.580, blue: 0.420)
    public static let clomeJournal = Color(red: 0.500, green: 0.410, blue: 0.660)
    public static let clomeReference = Color(red: 0.220, green: 0.560, blue: 0.560)
}
