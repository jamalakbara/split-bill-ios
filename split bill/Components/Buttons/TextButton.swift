//
//  TextButton.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct TextButton: View {
    let text: String
    let textColor: Color
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    let isUnderlined: Bool
    let action: () -> Void

    init(
        text: String,
        textColor: Color = Color(hex: "#003049"),
        fontSize: CGFloat = 16,
        fontWeight: Font.Weight = .semibold,
        isUnderlined: Bool = true,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.textColor = textColor
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.isUnderlined = isUnderlined
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.custom("Roboto", size: fontSize))
                .fontWeight(fontWeight)
                .foregroundColor(textColor)
                .underline(isUnderlined)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        TextButton(
            text: "Already have an account? Log in",
            action: { print("Log in tapped") }
        )

        TextButton(
            text: "Skip",
            fontSize: 16,
            action: { print("Skip tapped") }
        )

        TextButton(
            text: "Don't have an account? Sign up",
            textColor: .blue,
            isUnderlined: false,
            action: { print("Sign up tapped") }
        )
    }
    .padding()
    .background(Color(hex: "#eae2b7"))
}