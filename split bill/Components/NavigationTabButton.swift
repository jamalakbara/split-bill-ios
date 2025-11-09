//
//  NavigationTabButton.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct NavigationTabButton: View {
    let icon: String
    let text: String
    let isActive: Bool
    let activeColor: Color
    let inactiveColor: Color
    let fontSize: CGFloat
    let iconSize: CGFloat
    let action: () -> Void

    init(
        icon: String,
        text: String,
        isActive: Bool = false,
        activeColor: Color = Color(hex: "#f77f00"),
        inactiveColor: Color = Color(hex: "#003049"),
        fontSize: CGFloat = 12,
        iconSize: CGFloat = 24,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.text = text
        self.isActive = isActive
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.fontSize = fontSize
        self.iconSize = iconSize
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: iconSize))
                    .foregroundColor(isActive ? activeColor : inactiveColor)

                Text(text)
                    .font(.custom("Roboto", size: fontSize))
                    .foregroundColor(isActive ? activeColor : inactiveColor)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    HStack(spacing: 40) {
        NavigationTabButton(
            icon: "house.fill",
            text: "Home",
            isActive: true,
            action: { print("Home tapped") }
        )

        NavigationTabButton(
            icon: "person.2",
            text: "Groups",
            action: { print("Groups tapped") }
        )

        NavigationTabButton(
            icon: "person.3",
            text: "People",
            action: { print("People tapped") }
        )

        NavigationTabButton(
            icon: "gearshape",
            text: "Settings",
            action: { print("Settings tapped") }
        )
    }
    .padding()
    .background(Color.white)
}