//
//  HeaderView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    let cornerRadius: CGFloat
    let showBackButton: Bool
    let showEditButton: Bool
    let backButtonAction: (() -> Void)?
    let editButtonAction: (() -> Void)?
    let editButtonIcon: String

    init(
        title: String,
        backgroundColor: Color = Color(hex: "#003049"),
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 48,
        showBackButton: Bool = true,
        showEditButton: Bool = false,
        backButtonAction: (() -> Void)? = nil,
        editButtonAction: (() -> Void)? = nil,
        editButtonIcon: String = "pencil"
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.showBackButton = showBackButton
        self.showEditButton = showEditButton
        self.backButtonAction = backButtonAction
        self.editButtonAction = editButtonAction
        self.editButtonIcon = editButtonIcon
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                // Back button
                if showBackButton {
                    CircularIconButton(
                        icon: "arrow.left",
                        action: {
                            backButtonAction?()
                        }
                    )
                } else {
                    Color.clear
                        .frame(width: 56, height: 56)
                }

                Spacer()

                // Title
                Text(title)
                    .font(.custom("Roboto", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(foregroundColor)

                Spacer()

                // Edit button
                if showEditButton {
                    CircularIconButton(
                        icon: editButtonIcon,
                        action: {
                            editButtonAction?()
                        }
                    )
                } else {
                    Color.clear
                        .frame(width: 56, height: 56)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 24)
        }
        .background(
            backgroundColor
                .cornerRadius(cornerRadius, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea(edges: .top)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
    }
}

#Preview {
    VStack(spacing: 20) {
        // Header with back and edit buttons
        HeaderView(
            title: "Bill Detail",
            showBackButton: true,
            showEditButton: true,
            backButtonAction: { print("Back tapped") },
            editButtonAction: { print("Edit tapped") }
        )

        // Header with only back button
        HeaderView(
            title: "Settings",
            showBackButton: true,
            showEditButton: false,
            backButtonAction: { print("Back tapped") }
        )

        // Header with no buttons
        HeaderView(
            title: "Dashboard",
            showBackButton: false,
            showEditButton: false
        )
    }
    .background(Color(hex: "#eae2b7"))
}