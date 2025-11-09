//
//  SecondaryCard.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct SecondaryCard<Content: View>: View {
    let backgroundColor: Color
    let padding: CGFloat
    let content: () -> Content

    init(
        backgroundColor: Color = DesignConstants.Colors.background.opacity(0.3),
        padding: CGFloat = DesignConstants.cardPadding,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.padding = padding
        self.content = content
    }

    var body: some View {
        BaseCard(
            backgroundColor: backgroundColor,
            borderColor: DesignConstants.Colors.textPrimary.opacity(0.1),
            borderWidth: DesignConstants.BorderWidth.thin,
            shadowRadius: 0,
            shadowOffset: .zero,
            padding: padding
        ) {
            content()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Default secondary card
        SecondaryCard {
            VStack(alignment: .leading) {
                Text("Secondary Card")
                    .font(DesignConstants.Typography.headline)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                Text("This is a light background card with thin border and no shadow")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        // Custom background secondary card
        SecondaryCard(
            backgroundColor: DesignConstants.Colors.accent.opacity(0.2)
        ) {
            VStack(alignment: .leading) {
                Text("Custom Background")
                    .font(DesignConstants.Typography.headline)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                Text("This secondary card has a custom background color")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    .padding()
    .background(DesignConstants.Colors.background)
}