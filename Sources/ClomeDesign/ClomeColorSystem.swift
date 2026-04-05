import SwiftUI

// MARK: - Clome Unified Color System

/// Unified color system for the Clome ecosystem.
/// Dark mode uses Clome's opacity-based layering on #0E0E12.
/// Light mode uses cool neutrals for the standalone Clome Flow app.
public enum ClomeColor {

    // MARK: - Base (Clome Dark)

    /// #0E0E12 — the Clome base color
    public static let base = Color(red: 0.055, green: 0.055, blue: 0.071)

    /// Surfaces built via white overlay on base
    public static let surface = Color.white.opacity(0.03)
    public static let surfaceAlt = Color.white.opacity(0.06)
    public static let surfaceElevated = Color.white.opacity(0.09)
    public static let surfaceHighest = Color.white.opacity(0.12)

    /// Borders and dividers
    public static let border = Color.white.opacity(0.06)
    public static let borderSubtle = Color.white.opacity(0.04)
    public static let borderStrong = Color.white.opacity(0.10)

    // MARK: - Text Hierarchy (Dark Mode)

    public static let textPrimary = Color.white.opacity(0.90)
    public static let textSecondary = Color.white.opacity(0.50)
    public static let textTertiary = Color.white.opacity(0.30)
    public static let textMuted = Color.white.opacity(0.15)

    // MARK: - Light Mode Neutrals (for Clome Flow iOS)

    public static let lightBg = Color(red: 0.957, green: 0.957, blue: 0.961)
    public static let lightSurface = Color(red: 0.984, green: 0.984, blue: 0.988)
    public static let lightSurfaceAlt = Color(red: 0.918, green: 0.922, blue: 0.929)
    public static let lightBorder = Color(red: 0.055, green: 0.055, blue: 0.063).opacity(0.05)
    public static let lightTextPrimary = Color(red: 0.055, green: 0.055, blue: 0.063)
    public static let lightTextSecondary = Color(red: 0.357, green: 0.361, blue: 0.380)
    public static let lightTextTertiary = Color(red: 0.576, green: 0.580, blue: 0.592)

    // MARK: - Accent

    /// Clome primary accent blue (#6590FF)
    public static let accent = Color(red: 0.38, green: 0.56, blue: 1.0)

    // MARK: - Semantic

    public static func success(dark: Bool) -> Color {
        dark ? Color(red: 0.310, green: 0.700, blue: 0.580) : Color(red: 0.175, green: 0.580, blue: 0.380)
    }

    public static func warning(dark: Bool) -> Color {
        dark ? Color(red: 0.910, green: 0.828, blue: 0.416) : Color(red: 0.735, green: 0.555, blue: 0.140)
    }

    public static func error(dark: Bool) -> Color {
        dark ? Color(red: 0.933, green: 0.420, blue: 0.370) : Color(red: 0.780, green: 0.290, blue: 0.230)
    }

    public static func info(dark: Bool) -> Color {
        dark ? Color(red: 0.420, green: 0.665, blue: 0.878) : Color(red: 0.260, green: 0.490, blue: 0.720)
    }

    // MARK: - Gold (Rewards/XP)

    public static let gold = Color(red: 0.735, green: 0.667, blue: 0.275)
    public static let goldLight = Color(red: 0.910, green: 0.828, blue: 0.416)
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
