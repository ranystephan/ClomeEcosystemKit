import SwiftUI

// MARK: - Clome Typography Tokens

/// Unified type scale for the Clome ecosystem.
/// Uses SF Pro (`.default` design) instead of SF Pro Rounded.
/// Monospaced stays SF Mono for timestamps and data labels.
public enum ClomeFont {
    case displayLarge   // 40pt bold
    case displayMedium  // 32pt bold
    case title1         // 24pt semibold — section headers
    case title2         // 20pt semibold — card titles
    case title3         // 17pt medium — sub-section headers
    case body           // 15pt regular — main body text (iOS), 13pt on macOS
    case bodyMedium     // 15pt medium
    case bodyBold       // 15pt semibold
    case callout        // 13pt medium — pill labels, chips
    case caption        // 11pt regular — metadata
    case micro          // 9pt medium — badge counts
    case timeDisplay    // 16pt medium monospaced
    case timestamp      // 10pt medium monospaced
    case sectionLabel   // 10pt mono bold, tracking 2.0
    case greetingLight  // 28pt light
    case greetingBold   // 28pt semibold
    case dateMuted      // 13pt regular

    public var font: Font {
        switch self {
        case .displayLarge:
            return .system(size: 40, weight: .bold, design: .default)
        case .displayMedium:
            return .system(size: 32, weight: .bold, design: .default)
        case .title1:
            return .system(size: 24, weight: .semibold, design: .default)
        case .title2:
            return .system(size: 20, weight: .semibold, design: .default)
        case .title3:
            return .system(size: 17, weight: .medium, design: .default)
        case .body:
            #if os(macOS)
            return .system(size: 13, weight: .regular, design: .default)
            #else
            return .system(size: 15, weight: .regular, design: .default)
            #endif
        case .bodyMedium:
            #if os(macOS)
            return .system(size: 13, weight: .medium, design: .default)
            #else
            return .system(size: 15, weight: .medium, design: .default)
            #endif
        case .bodyBold:
            #if os(macOS)
            return .system(size: 13, weight: .semibold, design: .default)
            #else
            return .system(size: 15, weight: .semibold, design: .default)
            #endif
        case .callout:
            return .system(size: 13, weight: .medium, design: .default)
        case .caption:
            return .system(size: 11, weight: .regular, design: .default)
        case .micro:
            return .system(size: 9, weight: .medium, design: .default)
        case .timeDisplay:
            return .system(size: 16, weight: .medium, design: .monospaced)
        case .timestamp:
            return .system(size: 10, weight: .medium, design: .monospaced)
        case .sectionLabel:
            return .system(size: 10, weight: .bold, design: .monospaced)
        case .greetingLight:
            return .system(size: 28, weight: .light, design: .default)
        case .greetingBold:
            return .system(size: 28, weight: .semibold, design: .default)
        case .dateMuted:
            return .system(size: 13, weight: .regular, design: .default)
        }
    }

    public var tracking: CGFloat {
        switch self {
        case .displayLarge: return -0.5
        case .displayMedium: return -0.3
        case .title1: return -0.2
        case .title2: return -0.1
        case .title3, .body, .bodyMedium, .bodyBold: return 0
        case .callout: return 0.1
        case .caption: return 0.2
        case .micro: return 0.5
        case .timeDisplay: return 0.8
        case .timestamp: return 0.6
        case .sectionLabel: return 2.0
        case .greetingLight, .greetingBold: return -0.56
        case .dateMuted: return 0.1
        }
    }
}

// MARK: - View Extension

extension View {
    public func clomeFont(_ token: ClomeFont) -> some View {
        self
            .font(token.font)
            .tracking(token.tracking)
    }
}
