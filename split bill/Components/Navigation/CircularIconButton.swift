//
//  CircularIconButton.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct CircularIconButton: View {
    let icon: String
    let backgroundColor: Color
    let iconColor: Color
    let size: CGFloat
    let iconSize: CGFloat
    let borderColor: Color
    let borderWidth: CGFloat
    let shadowColor: Color?
    let shadowRadius: CGFloat
    let shadowOffset: CGSize
    let action: () -> Void

    init(
        icon: String,
        backgroundColor: Color = Color(hex: "#f77f00"),
        iconColor: Color = .white,
        size: CGFloat = 48,
        iconSize: CGFloat = 20,
        borderColor: Color = .white,
        borderWidth: CGFloat = 4,
        shadowColor: Color? = nil,
        shadowRadius: CGFloat = 0,
        shadowOffset: CGSize = .zero,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.backgroundColor = backgroundColor
        self.iconColor = iconColor
        self.size = size
        self.iconSize = iconSize
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(backgroundColor)
                    .overlay(
                        Circle()
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
                    .shadow(
                        color: shadowColor ?? .clear,
                        radius: shadowRadius,
                        x: shadowOffset.width,
                        y: shadowOffset.height
                    )

                Image(systemName: icon)
                    .font(.system(size: iconSize, weight: .medium))
                    .foregroundColor(iconColor)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    HStack(spacing: 20) {
        CircularIconButton(
            icon: "arrow.left",
            action: { print("Back tapped") }
        )

        CircularIconButton(
            icon: "pencil",
            action: { print("Edit tapped") }
        )

        CircularIconButton(
            icon: "bell",
            action: { print("Notification tapped") }
        )

        CircularIconButton(
            icon: "plus",
            backgroundColor: Color(hex: "#003049"),
            action: { print("Add tapped") }
        )
    }
    .padding()
    .background(Color(hex: "#eae2b7"))
}