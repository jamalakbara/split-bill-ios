//
//  SettingsView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    @Binding var showUserProfile: Bool
    @Binding var userProfileFromSettings: Bool
    @Binding var showNotifications: Bool
    @Binding var showAchievements: Bool
    @State private var userName = "stambol"
    @State private var userEmail = "stambol@email.com"
    @State private var profileImageURL = "https://images.unsplash.com/photo-1750535135451-7c20e24b60c1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjYXJ0b29uJTIwYXZhdGFyJTIwaWxsdXN0cmF0aW9ufGVufDF8fHx8MTc2MjU2OTYwOHww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"

    let settingsSections = [
        SettingsSection(
            title: "Account",
            items: [
                SettingsItem(icon: "bell.fill", label: "Notifications", color: DesignConstants.Colors.accent),
                SettingsItem(icon: "creditcard.fill", label: "Accounts", color: DesignConstants.Colors.danger),
                SettingsItem(icon: "trophy.fill", label: "Achievements", color: DesignConstants.Colors.secondary),
            ]
        ),
        SettingsSection(
            title: "Preferences",
            items: [
                SettingsItem(icon: "lock.fill", label: "Privacy & Security", color: DesignConstants.Colors.secondary),
            ]
        ),
        SettingsSection(
            title: "Support",
            items: [
                SettingsItem(icon: "questionmark.circle.fill", label: "Help & FAQ", color: DesignConstants.Colors.accent),
            ]
        ),
    ]

    var body: some View {
        ScreenContainer(
            title: "Settings",
            backgroundColor: DesignConstants.Colors.background,
            showBackButton: true,
            showEditButton: false,
            backButtonAction: {
                showSettings = false
            },
            hasScrollView: true
        ) {
            LazyVStack(spacing: DesignConstants.contentSpacing) {
                // Profile Card
                profileCard

                // Settings Sections
                settingsSectionsList

                // Logout Button
                logoutButton

                // App Version
                appVersion
            }
        }
    }


    // MARK: - Profile Card (Scrollable version)
    private var profileCard: some View {
        StandardCard {
            HStack(spacing: 16) {
                // Profile Image Button
                Button(action: {
                    userProfileFromSettings = true
                    showSettings = false
                    showUserProfile = true
                }) {
                    AsyncImage(url: URL(string: profileImageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Circle()
                            .frame(width: 64, height: 64)
                            .foregroundColor(DesignConstants.Colors.textSecondary.opacity(0.3))
                    }
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(DesignConstants.Colors.white, lineWidth: 3)
                    )
                }
                .buttonStyle(PlainButtonStyle())

                // User Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(userName)
                        .font(DesignConstants.Typography.body)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                        .fontWeight(.medium)

                    Text(userEmail)
                        .font(DesignConstants.Typography.callout)
                        .foregroundColor(DesignConstants.Colors.textSecondary)
                }

                Spacer()

                // Edit Profile Button
                CircularIconButton(
                    icon: "pencil",
                    backgroundColor: DesignConstants.Colors.secondary,
                    action: {
                        userProfileFromSettings = true
                        showSettings = false
                        showUserProfile = true
                    }
                )
            }
        }
    }

    // MARK: - Settings Sections List
    private var settingsSectionsList: some View {
        ForEach(settingsSections.indices, id: \.self) { sectionIndex in
            let section = settingsSections[sectionIndex]

            VStack(spacing: DesignConstants.contentSpacing) {
                // Section Title
                HStack {
                    Text(section.title)
                        .font(DesignConstants.Typography.headline)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                        .fontWeight(.bold)
                    Spacer()
                }

                // Section Items
                VStack(spacing: DesignConstants.contentSpacing) {
                    ForEach(section.items.indices, id: \.self) { itemIndex in
                        let item = section.items[itemIndex]
                        settingsItemButton(item: item)
                    }
                }
            }
        }
    }

    // MARK: - Settings Item Button
    private func settingsItemButton(item: SettingsItem) -> some View {
        StandardCard() {
            Button(action: {
                handleSettingsTap(item: item)
            }) {
                HStack(spacing: 12) {
                    // Icon
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(item.color)

                        Image(systemName: item.icon)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }

                    // Label
                    Text(item.label)
                        .font(DesignConstants.Typography.body)
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    Spacer()

                    // Chevron
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(DesignConstants.Colors.textPrimary.opacity(0.5))
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    // MARK: - Logout Button
    private var logoutButton: some View {
        PrimaryButton(
            text: "Log Out",
            icon: "arrow.right.square",
            backgroundColor: DesignConstants.Colors.danger,
            foregroundColor: .white,
            borderColor: DesignConstants.Colors.textPrimary,
            cornerRadius: DesignConstants.CornerRadius.large,
            shadowOffset: 3,
            action: {
                // Handle logout - navigate back to login
                showSettings = false
            }
        )
    }

    // MARK: - App Version
    private var appVersion: some View {
        Text("Version 1.0.0")
            .font(DesignConstants.Typography.caption)
            .foregroundColor(DesignConstants.Colors.textPrimary.opacity(0.5))
            .padding(.top, DesignConstants.contentSpacing)
    }

    // MARK: - Actions
    private func handleSettingsTap(item: SettingsItem) {
        switch item.label {
        case "Accounts":
            // Navigate to payment methods
            break
        case "Achievements":
            showSettings = false
            showAchievements = true
        case "Notifications":
            showNotifications = true
        case "Privacy & Security":
            // Navigate to privacy settings
            break
        case "Help & FAQ":
            // Navigate to help
            break
        default:
            break
        }
    }
}

// MARK: - Supporting Models
struct SettingsSection {
    let title: String
    let items: [SettingsItem]
}

struct SettingsItem {
    let icon: String
    let label: String
    let color: Color
}


// MARK: - Preview
#Preview {
    SettingsView(showSettings: .constant(false), showUserProfile: .constant(false), userProfileFromSettings: .constant(false), showNotifications: .constant(false), showAchievements: .constant(false))
}
