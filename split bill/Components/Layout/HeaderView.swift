//
//  HeaderView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

enum HeaderType {
    case simple
    case detail
    case custom
}

struct HeaderView: View {
    let title: String?
    let backgroundColor: Color
    let foregroundColor: Color
    let cornerRadius: CGFloat
    let showBackButton: Bool
    let showEditButton: Bool
    let backButtonAction: (() -> Void)?
    let editButtonAction: (() -> Void)?
    let editButtonIcon: String
    let headerType: HeaderType
    let customContent: HeaderContentView?
    let headerHeight: CGFloat

    init(
        title: String? = nil,
        backgroundColor: Color = Color(hex: "#003049"),
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 48,
        showBackButton: Bool = true,
        showEditButton: Bool = false,
        backButtonAction: (() -> Void)? = nil,
        editButtonAction: (() -> Void)? = nil,
        editButtonIcon: String = "pencil",
        headerType: HeaderType = .simple,
        customContent: HeaderContentView? = nil,
        headerHeight: CGFloat = 100
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
        self.headerType = headerType
        self.customContent = customContent
        self.headerHeight = headerHeight
    }

    var body: some View {
        VStack(spacing: 0) {
            // Navigation Header Container
            VStack(spacing: 0) {
                // Navigation buttons (always shown)
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

                    // Title (for simple and custom headers)
                    if (headerType == .simple || headerType == .custom), let title = title {
                        Text(title)
                            .font(.custom("Roboto", size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(foregroundColor)
                    } else {
                        Color.clear
                            .frame(width: 100) // Placeholder for centering
                    }

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
            }

            // Custom content (for detail and custom headers)
            if headerType == .detail || headerType == .custom {
                if let customContent = customContent {
                    customContent
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                }
            } else {
                Spacer() // This will take up all remaining space, pushing navigation header to top
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .frame(height: headerHeight)
        .background(
            backgroundColor
                .cornerRadius(cornerRadius, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea(edges: .top)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(headerAccessibilityLabel)
    }

    // MARK: - Accessibility Helpers
    private var headerAccessibilityLabel: String {
        var components: [String] = []

        // Add title if available
        if let title = title, (headerType == .simple || headerType == .custom) {
            components.append(title)
        }

        // Add actions
        if showBackButton {
            components.append("Back button")
        }

        if showEditButton {
            components.append(accessibilityActionLabel(for: editButtonIcon))
        }

        // For detail headers, use custom content as part of the label
        if headerType == .detail, let customContent = customContent {
            components.append("Detail view")
        }

        return components.isEmpty ? "Header" : components.joined(separator: ", ")
    }

    private func accessibilityActionLabel(for icon: String) -> String {
        switch icon {
        case "bell", "bell.fill":
            return "Notifications"
        case "square.and.arrow.up":
            return "Share"
        case "pencil", "pencil.circle":
            return "Edit"
        default:
            return "Action"
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Simple Header with back and edit buttons
        HeaderView(
            title: "Bill Detail",
            showBackButton: true,
            showEditButton: true,
            backButtonAction: { print("Back tapped") },
            editButtonAction: { print("Edit tapped") },
            headerType: .simple
        )

        // Detail Header with custom content
        HeaderView(
            showBackButton: true,
            showEditButton: true,
            backButtonAction: { print("Back tapped") },
            editButtonAction: { print("Bell tapped") },
            editButtonIcon: "bell",
            headerType: .detail,
            customContent: HeaderContentView(
                type: .groupDetail(
                    groupIcon: "🐻",
                    groupName: "Roommates",
                    memberCount: 4,
                    editButtonAction: { print("Edit group tapped") }
                )
            ),
            headerHeight: 280
        )

        // Custom Header with simple content
        HeaderView(
            showBackButton: true,
            showEditButton: false,
            backButtonAction: { print("Back tapped") },
            editButtonAction: nil,
            editButtonIcon: "pencil",
            headerType: .custom,
            customContent: HeaderContentView(
                type: .simple(title: "Profile", subtitle: "Premium Member")
            ),
            headerHeight: 180
        )
    }
    .background(Color(hex: "#eae2b7"))
}
