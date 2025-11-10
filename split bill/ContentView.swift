//
//  ContentView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct ContentView: View {
    // Authentication flow states
    @State private var showSignUp = false
    @State private var showOnboarding = false
    @State private var showMainScreen = false

    // Global navigation state
    @State private var selectedTab: AppTab = .home

    // Modal sheet states (keep for detail views)
    @State private var showViewBill = false
    @State private var selectedBill: RecentBill?
    @State private var showUserProfile = false
    @State private var selectedUserProfile: UserProfile?
    @State private var userProfileFromSettings = false  // Track if user came from settings
    @State private var showNotifications = false
    @State private var showAchievements = false
    @State private var showGroupDetail = false
    @State private var selectedGroup: GroupModel?

    // Helper states for modal navigation
    @State private var showGroups = false
    @State private var showSettings = false

    var body: some View {
        // Authentication flow
        if showViewBill, let bill = selectedBill {
            ViewBillView(
                bill: bill,
                showViewBill: $showViewBill,
                selectedBill: $selectedBill,
                showUserProfile: $showUserProfile,
                selectedUserProfile: $selectedUserProfile,
                userProfileFromSettings: $userProfileFromSettings
            )
            .sheet(isPresented: $showNotifications) {
                NotificationsView(showNotifications: $showNotifications)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(DesignConstants.CornerRadius.large)
            }
        } else if showGroupDetail, let group = selectedGroup {
            GroupDetailView(
                group: group,
                showGroupDetail: $showGroupDetail,
                showGroups: $showGroups,
                showNotifications: $showNotifications,
                showSettings: $showSettings
            )
            .sheet(isPresented: $showNotifications) {
                NotificationsView(showNotifications: $showNotifications)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(DesignConstants.CornerRadius.large)
            }
        } else if showUserProfile {
            UserProfileView(
                showUserProfile: $showUserProfile,
                userProfileFromSettings: $userProfileFromSettings,
                showNotifications: $showNotifications,
                userProfile: selectedUserProfile
            )
            .sheet(isPresented: $showNotifications) {
                NotificationsView(showNotifications: $showNotifications)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(DesignConstants.CornerRadius.large)
            }
        } else if showAchievements {
            AchievementsView(
                showAchievements: $showAchievements,
                showSettings: $showSettings,
                showNotifications: $showNotifications
            )
            .sheet(isPresented: $showNotifications) {
                NotificationsView(showNotifications: $showNotifications)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(DesignConstants.CornerRadius.large)
            }
        } else if showOnboarding {
            OnboardingView(showMainScreen: $showMainScreen)
        } else if showSignUp {
            SignUpView(
                showLogin: $showSignUp,
                showOnboarding: $showOnboarding,
                showMainScreen: $showMainScreen
            )
            .sheet(isPresented: $showNotifications) {
                NotificationsView(showNotifications: $showNotifications)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(DesignConstants.CornerRadius.large)
            }
        } else if showMainScreen {
            // Main app with tab-based navigation
            ZStack {
                // Tab content
                Group {
                    switch selectedTab {
                    case .home:
                        MainScreenView(
                            showViewBill: $showViewBill,
                            selectedBill: $selectedBill,
                            showNotifications: $showNotifications
                        )
                    case .groups:
                        GroupsView(
                            showGroupDetail: $showGroupDetail,
                            selectedGroup: $selectedGroup
                        )
                    case .people:
                        FriendsView(
                            showUserProfile: $showUserProfile,
                            selectedUserProfile: $selectedUserProfile
                        )
                    case .settings:
                        SettingsView(showAchievements: $showAchievements)
                    }
                }

                // Global bottom navigation
                GlobalBottomNavigation(
                    selectedTab: $selectedTab,
                    floatingButtonAction: {
                        // Handle floating add button action
                        print("Floating add button tapped")
                    }
                )
            }
            .sheet(isPresented: $showNotifications) {
                NotificationsView(showNotifications: $showNotifications)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(DesignConstants.CornerRadius.large)
            }
            .sheet(isPresented: $showUserProfile) {
                UserProfileView(
                    showUserProfile: $showUserProfile,
                    userProfileFromSettings: $userProfileFromSettings,
                    showNotifications: $showNotifications,
                    userProfile: selectedUserProfile
                )
            }
            .sheet(isPresented: $showAchievements) {
                AchievementsView(
                    showAchievements: $showAchievements,
                    showSettings: $showSettings,
                    showNotifications: $showNotifications
                )
            }
        } else {
            LoginView(showSignUp: $showSignUp, showMainScreen: $showMainScreen)
                .sheet(isPresented: $showNotifications) {
                    NotificationsView(showNotifications: $showNotifications)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(DesignConstants.CornerRadius.large)
                }
        }
    }
}

#Preview("Login View") {
    ContentView()
}
