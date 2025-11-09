//
//  StandardCard.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct StandardCard<Content: View>: View {
    let cornerRadius: CGFloat
    let padding: CGFloat
    let content: () -> Content

    init(
        cornerRadius: CGFloat = DesignConstants.CornerRadius.card,
        padding: CGFloat = DesignConstants.cardPadding,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.content = content
    }

    var body: some View {
        BaseCard(
            backgroundColor: DesignConstants.Colors.white,
            borderColor: DesignConstants.Colors.textPrimary,
            borderWidth: DesignConstants.BorderWidth.card,
            cornerRadius: cornerRadius,
            shadowColor: DesignConstants.Colors.textPrimary,
            shadowRadius: DesignConstants.Shadow.radius,
            shadowOffset: CGSize(width: DesignConstants.Shadow.card.width, height: DesignConstants.Shadow.card.height),
            padding: padding
        ) {
            content()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Regular standard card
        StandardCard {
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

        // Large corner radius card
        StandardCard(cornerRadius: DesignConstants.CornerRadius.large) {
            VStack(alignment: .leading) {
                Text("Large Radius Card")
                    .font(DesignConstants.Typography.headline)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                Text("This card has larger corner radius")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        // Custom padding card
        StandardCard(padding: 24) {
            VStack(alignment: .leading) {
                Text("Extra Padding Card")
                    .font(DesignConstants.Typography.headline)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                Text("This card has extra padding")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    .padding()
    .background(DesignConstants.Colors.background)
}