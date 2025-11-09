//
//  PrimaryButton.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct PrimaryButton: View {
    let text: String
    let icon: String?
    let backgroundColor: Color
    let foregroundColor: Color
    let borderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    let height: CGFloat
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let shadowOffset: CGFloat
    let action: () -> Void

    init(
        text: String,
        icon: String? = nil,
        backgroundColor: Color = Color(hex: "#fcbf49"),
        foregroundColor: Color = Color(hex: "#003049"),
        borderColor: Color = Color(hex: "#003049"),
        borderWidth: CGFloat = 4,
        cornerRadius: CGFloat = 24,
        height: CGFloat = 56,
        fontSize: CGFloat = 16,
        fontWeight: Font.Weight = .medium,
        shadowOffset: CGFloat = 6,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.height = height
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.shadowOffset = shadowOffset
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: fontSize, weight: fontWeight))
                        .foregroundColor(foregroundColor)
                }

                Text(text)
                    .font(.custom("Roboto", size: fontSize))
                    .fontWeight(fontWeight)
                    .foregroundColor(foregroundColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: borderColor, radius: 0, x: shadowOffset, y: shadowOffset)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(
            text: "Sign Up",
            action: { print("Sign Up tapped") }
        )

        PrimaryButton(
            text: "Get Started",
            backgroundColor: Color(hex: "#f77f00"),
            action: { print("Get Started tapped") }
        )

        PrimaryButton(
            text: "SHARE",
            icon: "square.and.arrow.up",
            cornerRadius: 28,
            shadowOffset: 4,
            action: { print("Share tapped") }
        )

        PrimaryButton(
            text: "Login",
            backgroundColor: Color(hex: "#e5e5e5").opacity(0.3),
            height: 62,
            action: { print("Login tapped") }
        )
    }
    .padding()
    .background(Color(hex: "#eae2b7"))
}