import SwiftUI

// MARK: - Clome Unified Color System

/// Unified color system for the Clome ecosystem.
/// Dark mode and light mode intentionally mirror the calmer Clome Flow palette:
/// restrained neutrals, thin borders, and one structural accent.
public enum ClomeColor {

    // MARK: - Base (Dark)

    /// Deep ink background
    public static let base = Color(red: 0.059, green: 0.067, blue: 0.090)

    /// Layered dark surfaces
    public static let surface = Color(red: 0.102, green: 0.114, blue: 0.153)
    public static let surfaceAlt = Color(red: 0.142, green: 0.157, blue: 0.200)
    public static let surfaceElevated = Color(red: 0.176, green: 0.192, blue: 0.235)
    public static let surfaceHighest = Color(red: 0.239, green: 0.255, blue: 0.333)

    /// Borders and dividers
    public static let border = Color(red: 0.176, green: 0.192, blue: 0.235)
    public static let borderSubtle = Color(red: 0.176, green: 0.192, blue: 0.235).opacity(0.65)
    public static let borderStrong = Color(red: 0.239, green: 0.255, blue: 0.333)

    // MARK: - Text Hierarchy (Dark)

    public static let textPrimary = Color(red: 0.953, green: 0.957, blue: 0.969)
    public static let textSecondary = Color(red: 0.773, green: 0.792, blue: 0.831)
    public static let textTertiary = Color(red: 0.616, green: 0.635, blue: 0.706)
    public static let textMuted = Color(red: 0.482, green: 0.498, blue: 0.588)

    // MARK: - Light Mode Neutrals

    public static let lightBg = Color(red: 0.973, green: 0.969, blue: 0.953)
    public static let lightSurface = Color(red: 0.988, green: 0.984, blue: 0.973)
    public static let lightSurfaceAlt = Color(red: 0.953, green: 0.957, blue: 0.969)
    public static let lightBorder = Color(red: 0.059, green: 0.067, blue: 0.090).opacity(0.08)
    public static let lightTextPrimary = Color(red: 0.059, green: 0.067, blue: 0.090)
    public static let lightTextSecondary = Color(red: 0.361, green: 0.376, blue: 0.471)
    public static let lightTextTertiary = Color(red: 0.616, green: 0.635, blue: 0.706)

    // MARK: - Accent

    /// Structural graphite accent used sparingly across the shell
    public static let accent = Color(red: 0.247, green: 0.667, blue: 0.616)

    // MARK: - Semantic

    public static func success(dark: Bool) -> Color {
        dark ? Color(red: 0.322, green: 0.729, blue: 0.588) : Color(red: 0.227, green: 0.561, blue: 0.443)
    }

    public static func warning(dark: Bool) -> Color {
        dark ? Color(red: 0.922, green: 0.722, blue: 0.420) : Color(red: 0.831, green: 0.533, blue: 0.243)
    }

    public static func error(dark: Bool) -> Color {
        dark ? Color(red: 0.902, green: 0.490, blue: 0.490) : Color(red: 0.753, green: 0.310, blue: 0.310)
    }

    public static func info(dark: Bool) -> Color {
        dark ? Color(red: 0.490, green: 0.678, blue: 0.882) : Color(red: 0.290, green: 0.498, blue: 0.753)
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
