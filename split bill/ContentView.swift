//
//  ContentView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showSignUp = false
    @State private var showOnboarding = false
    @State private var showMainScreen = false
    @State private var showViewBill = false
    @State private var selectedBill: RecentBill?
    @State private var showSettings = false
    @State private var showUserProfile = false
    @State private var selectedUserProfile: UserProfile?
    @State private var userProfileFromSettings = false  // Track if user came from settings
    @State private var showNotifications = false
    @State private var showFriends = false

    var body: some View {
        if showViewBill, let bill = selectedBill {
            ViewBillView(bill: bill, showViewBill: $showViewBill, selectedBill: $selectedBill, showUserProfile: $showUserProfile, selectedUserProfile: $selectedUserProfile, userProfileFromSettings: $userProfileFromSettings)
                .sheet(isPresented: $showNotifications) {
                    NotificationsView(showNotifications: $showNotifications)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(DesignConstants.CornerRadius.large)
                }
        } else if showSettings {
            SettingsView(showSettings: $showSettings, showUserProfile: $showUserProfile, userProfileFromSettings: $userProfileFromSettings, showNotifications: $showNotifications)
                .sheet(isPresented: $showNotifications) {
                    NotificationsView(showNotifications: $showNotifications)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(DesignConstants.CornerRadius.large)
                }
        } else if showFriends {
            FriendsView(showFriends: $showFriends, showUserProfile: $showUserProfile, selectedUserProfile: $selectedUserProfile, showNotifications: $showNotifications)
                .sheet(isPresented: $showNotifications) {
                    NotificationsView(showNotifications: $showNotifications)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(DesignConstants.CornerRadius.large)
                }
        } else if showUserProfile {
            UserProfileView(showUserProfile: $showUserProfile, userProfileFromSettings: $userProfileFromSettings, showNotifications: $showNotifications, userProfile: selectedUserProfile)
                .sheet(isPresented: $showNotifications) {
                    NotificationsView(showNotifications: $showNotifications)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(DesignConstants.CornerRadius.large)
                }
        } else if showMainScreen {
            MainScreenView(showViewBill: $showViewBill, selectedBill: $selectedBill, showSettings: $showSettings, showNotifications: $showNotifications, showFriends: $showFriends)
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