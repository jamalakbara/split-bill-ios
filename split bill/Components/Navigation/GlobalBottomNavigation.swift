//
//  GlobalBottomNavigation.swift
//  split bill
//
//  Created by Chairil Akbar on 11/11/25.
//

import SwiftUI

struct GlobalBottomNavigation: View {
    @Binding var selectedTab: AppTab
    let floatingButtonAction: () -> Void

    var body: some View {
        ZStack {
            // Main Navigation Bar
            VStack {
                Spacer()
                HStack {
                    // Home Tab
                    NavigationTabButton(
                        icon: AppTab.home.icon,
                        text: AppTab.home.title,
                        isActive: selectedTab == .home,
                        action: {
                            selectedTab = .home
                        }
                    )

                    Spacer()

                    // Groups Tab
                    NavigationTabButton(
                        icon: AppTab.groups.icon,
                        text: AppTab.groups.title,
                        isActive: selectedTab == .groups,
                        action: {
                            selectedTab = .groups
                        }
                    )

                    Spacer()

                    // Placeholder space for floating button
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 56, height: 76)

                    Spacer()

                    // People Tab
                    NavigationTabButton(
                        icon: AppTab.people.icon,
                        text: AppTab.people.title,
                        isActive: selectedTab == .people,
                        action: {
                            selectedTab = .people
                        }
                    )

                    Spacer()

                    // Settings Tab
                    NavigationTabButton(
                        icon: AppTab.settings.icon,
                        text: AppTab.settings.title,
                        isActive: selectedTab == .settings,
                        action: {
                            selectedTab = .settings
                        }
                    )
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 20)
                .background(
                    Color.white
                        .shadow(color: .black.opacity(0.1), radius: 4, y: -2)
                )
            }
            .ignoresSafeArea(edges: .bottom)

            // Floating Add Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    CircularIconButton(
                        icon: "plus",
                        backgroundColor: Color(hex: "#003049"),
                        size: 56,
                        iconSize: 24,
                        shadowColor: .black.opacity(0.2),
                        shadowRadius: 8,
                        shadowOffset: CGSize(width: 0, height: 4),
                        action: floatingButtonAction
                    )
                    Spacer()
                }
                .padding(.bottom, 48) // Halfway above the navbar (20px navbar padding + 28px offset)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    GlobalBottomNavigation(
        selectedTab: .constant(.home),
        floatingButtonAction: {
            print("Floating add button tapped")
        }
    )
    .previewLayout(.sizeThatFits)
}