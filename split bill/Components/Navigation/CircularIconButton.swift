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
    let accessibilityLabel: String

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
        accessibilityLabel: String? = nil,
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
        self.accessibilityLabel = accessibilityLabel ?? CircularIconButton.defaultAccessibilityLabel(for: icon)
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
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint(for: icon))
    }

    // MARK: - Accessibility Helpers
    static func defaultAccessibilityLabel(for icon: String) -> String {
        switch icon {
        case "arrow.left", "chevron.left":
            return "Back"
        case "arrow.right", "chevron.right":
            return "Forward"
        case "pencil", "pencil.circle":
            return "Edit"
        case "bell", "bell.fill":
            return "Notifications"
        case "square.and.arrow.up":
            return "Share"
        case "plus", "plus.circle":
            return "Add"
        case "trash", "trash.circle":
            return "Delete"
        case "person", "person.circle":
            return "Profile"
        case "settings", "gearshape":
            return "Settings"
        default:
            return icon.replacingOccurrences(of: ".", with: " ").capitalized
        }
    }

    private func accessibilityHint(for icon: String) -> String {
        switch icon {
        case "arrow.left", "chevron.left":
            return "Navigate back to previous screen"
        case "pencil", "pencil.circle":
            return "Edit current item or content"
        case "bell", "bell.fill":
            return "View notifications and alerts"
        case "square.and.arrow.up":
            return "Share this content with others"
        case "plus", "plus.circle":
            return "Add new item or content"
        case "trash", "trash.circle":
            return "Delete current item or content"
        default:
            return "Perform action related to this button"
        }
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