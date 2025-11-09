//
//  SecondaryButton.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct SecondaryButton: View {
    let text: String
    let showChevron: Bool
    let isExpanded: Bool
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let height: CGFloat
    let fontSize: CGFloat
    let action: () -> Void

    init(
        text: String,
        showChevron: Bool = false,
        isExpanded: Bool = false,
        backgroundColor: Color = Color(hex: "#fcbf49"),
        foregroundColor: Color = Color(hex: "#003049"),
        borderColor: Color = Color(hex: "#003049"),
        borderWidth: CGFloat = 3,
        cornerRadius: CGFloat = 20,
        height: CGFloat = 40,
        fontSize: CGFloat = 14,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.showChevron = showChevron
        self.isExpanded = isExpanded
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.height = height
        self.fontSize = fontSize
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(text)
                    .font(.custom("Roboto", size: fontSize))
                    .foregroundColor(foregroundColor)

                if showChevron {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(foregroundColor)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        SecondaryButton(
            text: "See details",
            showChevron: true,
            isExpanded: false,
            action: { print("See details tapped") }
        )

        SecondaryButton(
            text: "See details",
            showChevron: true,
            isExpanded: true,
            action: { print("Hide details tapped") }
        )

        SecondaryButton(
            text: "View More",
            backgroundColor: Color(hex: "#f77f00"),
            height: 48,
            action: { print("View More tapped") }
        )
    }
    .padding()
    .background(Color(hex: "#eae2b7"))
}