//
//  DesignConstants.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct DesignConstants {

    // MARK: - Padding Values
    static let horizontalPadding: CGFloat = 24
    static let verticalPadding: CGFloat = 24
    static let contentSpacing: CGFloat = 16
    static let sectionSpacing: CGFloat = 32
    static let cardPadding: CGFloat = 16

    // MARK: - Form Specific
    static let formFieldSpacing: CGFloat = 16
    static let formButtonSpacing: CGFloat = 24

    // MARK: - Header Specific
    static let headerBottomPadding: CGFloat = 24

    // MARK: - Special Cases
    static let loginTopPadding: CGFloat = 55.12
    static let signUpTopPadding: CGFloat = 40

    // MARK: - Colors
    struct Colors {
        static let background = Color(hex: "#eae2b7")
        static let primary = Color(hex: "#003049")
        static let secondary = Color(hex: "#f77f00")
        static let accent = Color(hex: "#fcbf49")
        static let danger = Color(hex: "#d62828")
        static let white = Color.white
        static let textPrimary = Color(hex: "#003049")
        static let textSecondary = Color(hex: "#003049").opacity(0.6)
    }

    // MARK: - Typography
    struct Typography {
        static let largeTitle: Font = .custom("Roboto", size: 48).weight(.bold)
        static let title1: Font = .custom("Roboto", size: 24).weight(.bold)
        static let title2: Font = .custom("Roboto", size: 20).weight(.medium)
        static let headline: Font = .custom("Roboto", size: 16).weight(.medium)
        static let body: Font = .custom("Roboto", size: 16)
        static let callout: Font = .custom("Roboto", size: 14)
        static let caption: Font = .custom("Roboto", size: 12)
    }

    // MARK: - Corner Radius
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let xlarge: CGFloat = 32
        static let button: CGFloat = 24
        static let card: CGFloat = 16
        static let header: CGFloat = 48
    }

    // MARK: - Shadow
    struct Shadow {
        static let card = CGSize(width: 3, height: 3)
        static let button = CGSize(width: 4, height: 4)
        static let floatingButton = CGSize(width: 0, height: 4)
        static let radius: CGFloat = 0
        static let floatingRadius: CGFloat = 8
    }

    // MARK: - Border Width
    struct BorderWidth {
        static let thin: CGFloat = 2
        static let medium: CGFloat = 3
        static let thick: CGFloat = 4
        static let button: CGFloat = 4
        static let card: CGFloat = 4
    }
}