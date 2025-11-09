//
//  BaseCard.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct BaseCard<Content: View>: View {
    let backgroundColor: Color
    let borderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowOffset: CGSize
    let padding: CGFloat
    let content: () -> Content

    init(
        backgroundColor: Color = DesignConstants.Colors.white,
        borderColor: Color = DesignConstants.Colors.textPrimary,
        borderWidth: CGFloat = DesignConstants.BorderWidth.card,
        cornerRadius: CGFloat = DesignConstants.CornerRadius.card,
        shadowColor: Color = DesignConstants.Colors.textPrimary,
        shadowRadius: CGFloat = DesignConstants.Shadow.radius,
        shadowOffset: CGSize = CGSize(width: DesignConstants.Shadow.card.width, height: DesignConstants.Shadow.card.height),
        padding: CGFloat = DesignConstants.cardPadding,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.padding = padding
        self.content = content
    }

    var body: some View {
        content()
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: shadowColor, radius: shadowRadius, x: shadowOffset.width, y: shadowOffset.height)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
}

#Preview {
    VStack(spacing: 20) {
        // Standard card
        BaseCard {
            VStack(alignment: .leading) {
                Text("Standard Card")
                    .font(DesignConstants.Typography.headline)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                Text("This is a standard white card with border and shadow")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        // Accent card
        BaseCard(
            backgroundColor: DesignConstants.Colors.secondary,
            borderColor: DesignConstants.Colors.white,
            borderWidth: 4
        ) {
            VStack(alignment: .leading) {
                Text("Accent Card")
                    .font(DesignConstants.Typography.headline)
                    .foregroundColor(.white)

                Text("This is a colored card with white border")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(.white.opacity(0.9))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        // Secondary card
        BaseCard(
            backgroundColor: DesignConstants.Colors.background.opacity(0.3),
            borderColor: DesignConstants.Colors.textPrimary.opacity(0.1),
            borderWidth: DesignConstants.BorderWidth.thin,
            shadowRadius: 0,
            shadowOffset: .zero
        ) {
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
    }
    .padding()
    .background(DesignConstants.Colors.background)
}