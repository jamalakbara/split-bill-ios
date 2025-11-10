//
//  ScreenContainer.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct ScreenContainer<Content: View>: View {
    let title: String?
    let backgroundColor: Color
    let showBackButton: Bool
    let showEditButton: Bool
    let backButtonAction: (() -> Void)?
    let editButtonAction: (() -> Void)?
    let editButtonIcon: String
    let hasScrollView: Bool
    let customTopPadding: CGFloat?
    let headerType: HeaderType
    let customHeaderContent: HeaderContentView?
    let headerHeight: CGFloat
    let content: () -> Content

    init(
        title: String? = nil,
        backgroundColor: Color = DesignConstants.Colors.background,
        showBackButton: Bool = false,
        showEditButton: Bool = false,
        backButtonAction: (() -> Void)? = nil,
        editButtonAction: (() -> Void)? = nil,
        editButtonIcon: String = "pencil",
        hasScrollView: Bool = false,
        customTopPadding: CGFloat? = nil,
        headerType: HeaderType = .simple,
        customHeaderContent: HeaderContentView? = nil,
        headerHeight: CGFloat = 120,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.showBackButton = showBackButton
        self.showEditButton = showEditButton
        self.backButtonAction = backButtonAction
        self.editButtonAction = editButtonAction
        self.editButtonIcon = editButtonIcon
        self.hasScrollView = hasScrollView
        self.customTopPadding = customTopPadding
        self.headerType = headerType
        self.customHeaderContent = customHeaderContent
        self.headerHeight = headerHeight
        self.content = content
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header - always show if any button is needed or custom content
                if showBackButton || showEditButton || customHeaderContent != nil || headerType != .simple {
                    HeaderView(
                        title: title,
                        showBackButton: showBackButton,
                        showEditButton: showEditButton,
                        backButtonAction: backButtonAction ?? {},
                        editButtonAction: editButtonAction ?? {},
                        editButtonIcon: editButtonIcon,
                        headerType: headerType,
                        customContent: customHeaderContent,
                        headerHeight: headerHeight
                    )
                }

                // Content
                if hasScrollView {
                    ScrollView {
                        contentWithPadding()
                    }
                } else {
                    contentWithPadding()
                }
            }
        }
    }

    private func contentWithPadding() -> some View {
        content()
            .padding(.horizontal, DesignConstants.horizontalPadding)
            .padding(.top, customTopPadding ?? DesignConstants.verticalPadding)
            .padding(.bottom, DesignConstants.verticalPadding)
    }
}

#Preview {
    VStack(spacing: 20) {
        // With header and ScrollView
        ScreenContainer(
            title: "Example Screen",
            showBackButton: true,
            showEditButton: true,
            hasScrollView: true
        ) {
            VStack(spacing: 16) {
                Text("Content Area")
                    .font(DesignConstants.Typography.title1)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                ForEach(0..<5, id: \.self) { index in
                    HStack {
                        Text("Content Item \(index + 1)")
                            .font(DesignConstants.Typography.body)
                        Spacer()
                    }
                    .padding()
                    .background(DesignConstants.Colors.white)
                    .cornerRadius(DesignConstants.CornerRadius.card)
                }
            }
        }
        .frame(height: 400)

        // Without header
        ScreenContainer(
            hasScrollView: false
        ) {
            VStack(spacing: 16) {
                Text("Simple Screen")
                    .font(DesignConstants.Typography.title1)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                Text("This screen has no header and consistent padding.")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(height: 200)
    }
}