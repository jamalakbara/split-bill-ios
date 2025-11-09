//
//  UserProfileView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct UserProfileView: View {
    @Binding var showUserProfile: Bool
    @Binding var userProfileFromSettings: Bool
    @Binding var showNotifications: Bool
    let userProfile: UserProfile?

    // Mock debt data for friends
    private let friendDebts: [Int: DebtInfo] = [
        1: DebtInfo(amount: 22.50, youOwe: true),   // Cooper
        2: DebtInfo(amount: 45.00, youOwe: false),  // Warren
        3: DebtInfo(amount: 15.75, youOwe: true),   // Jessy
        4: DebtInfo(amount: 0, youOwe: false),      // Jacob - settled
        5: DebtInfo(amount: 30.00, youOwe: false),  // Sarah
        6: DebtInfo(amount: 12.50, youOwe: true),   // Michael
        7: DebtInfo(amount: 8.25, youOwe: false),   // Emma
        8: DebtInfo(amount: 18.00, youOwe: true),   // David
    ]

    private var isOwnProfile: Bool {
        userProfile == nil
    }

    private var displayName: String {
        userProfile?.name ?? "stambol"
    }

    private var displayImage: String {
        userProfile?.image ?? "https://images.unsplash.com/photo-1750535135451-7c20e24b60c1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxjYXJ0b29uJTIwYXZhdGFyJTIwaWxsdXN0cmF0aW9ufGVufDF8fHx8MTc2MjU2OTYwOHww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
    }

    private var isFriend: Bool {
        guard let profile = userProfile else { return false }
        return profile.id <= 8
    }

    private var debtInfo: DebtInfo? {
        guard let profile = userProfile, isFriend else { return nil }
        return friendDebts[profile.id]
    }

    var body: some View {
        ZStack {
            // Background layer
            DesignConstants.Colors.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Custom Profile Header
                customProfileHeader

                // Scrollable Content
                ScrollView {
                    LazyVStack(spacing: DesignConstants.contentSpacing) {
                        // Profile Content
                        if isOwnProfile {
                            ownProfileContent
                        } else if isFriend {
                            friendProfileContent
                        } else {
                            nonFriendProfileContent
                        }
                    }
                    .padding(EdgeInsets(top: DesignConstants.contentSpacing, leading: DesignConstants.horizontalPadding, bottom: DesignConstants.verticalPadding, trailing: DesignConstants.horizontalPadding))
                }
            }

            // Back Button and Notification Button Overlay
            VStack {
                HStack {
                    // Back Button
                    CircularIconButton(
                        icon: "arrow.left",
                        backgroundColor: DesignConstants.Colors.secondary,
                        action: {
                            if userProfileFromSettings {
                                // Navigate back to Settings
                                userProfileFromSettings = false
                                showUserProfile = false
                            } else {
                                // Navigate back to Main Screen
                                showUserProfile = false
                            }
                        }
                    )
                    .padding(.leading, 24)
                    .padding(.top, 20)

                    Spacer()

                    // Notification Button
                    CircularIconButton(
                        icon: "bell",
                        backgroundColor: DesignConstants.Colors.secondary,
                        action: {
                            userProfileFromSettings = false
                            showUserProfile = false
                            showNotifications = true
                        }
                    )
                    .padding(.trailing, 24)
                    .padding(.top, 20)
                }
                Spacer()
            }
        }
    }

    // MARK: - Custom Profile Header
    private var customProfileHeader: some View {
        VStack(spacing: 0) {
            // Header with notification button (back button overlay handles this)
            Color.clear
                .frame(height: 80) // Space for back and notification buttons

            // Profile Section
            VStack(spacing: DesignConstants.contentSpacing) {
                // Profile Image
                AsyncImage(url: URL(string: displayImage)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Circle()
                        .frame(width: 112, height: 112)
                        .foregroundColor(DesignConstants.Colors.textSecondary.opacity(0.3))
                }
                .frame(width: 112, height: 112)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                )

                // Profile Name
                Text(displayName)
                    .font(.custom("Roboto", size: 32))
                    .fontWeight(.black)
                    .foregroundColor(.white)

                // Action Button
                profileActionButton
            }
            .padding(.bottom, DesignConstants.verticalPadding)
        }
        .background(
            Color(hex: "#003049")
                .cornerRadius(48, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea(edges: .top)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
    }

    // MARK: - Profile Action Button
    private var profileActionButton: some View {
        Group {
            if isOwnProfile {
                PrimaryButton(
                    text: "Edit Profile",
                    icon: "pencil",
                    backgroundColor: DesignConstants.Colors.secondary,
                    foregroundColor: .white,
                    borderColor: .white,
                    cornerRadius: 28,
                    shadowOffset: 4,
                    action: {
                        // Navigate to edit profile
                    }
                )
            } else if isFriend, let debt = debtInfo {
                // Friend profile - show debt status
                if debt.isSettled {
                    PrimaryButton(
                        text: "Settled up! 🎉",
                        backgroundColor: DesignConstants.Colors.accent,
                        foregroundColor: DesignConstants.Colors.textPrimary,
                        borderColor: .white,
                        cornerRadius: 28,
                        shadowOffset: 4,
                        action: {}
                    )
                } else if debt.youOwe {
                    PrimaryButton(
                        text: "You owe $\(String(format: "%.2f", debt.amount))",
                        icon: "dollarsign.circle",
                        backgroundColor: DesignConstants.Colors.danger,
                        foregroundColor: .white,
                        borderColor: .white,
                        cornerRadius: 28,
                        shadowOffset: 4,
                        action: {}
                    )
                } else {
                    PrimaryButton(
                        text: "Owes you $\(String(format: "%.2f", debt.amount))",
                        icon: "dollarsign.circle",
                        backgroundColor: DesignConstants.Colors.accent,
                        foregroundColor: DesignConstants.Colors.textPrimary,
                        borderColor: .white,
                        cornerRadius: 28,
                        shadowOffset: 4,
                        action: {}
                    )
                }
            } else {
                // Non-friend profile - show add friend button
                PrimaryButton(
                    text: "Add Friend",
                    icon: "person.badge.plus",
                    backgroundColor: DesignConstants.Colors.accent,
                    foregroundColor: DesignConstants.Colors.textPrimary,
                    borderColor: .white,
                    cornerRadius: 28,
                    shadowOffset: 4,
                    action: {}
                )
            }
        }
        .padding(.horizontal, 24)
    }

    // MARK: - Own Profile Content
    private var ownProfileContent: some View {
        VStack(spacing: DesignConstants.sectionSpacing) {
            // Statistics Cards
            VStack(spacing: DesignConstants.contentSpacing) {
                HStack {
                    Text("Your Stats")
                        .font(DesignConstants.Typography.headline)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack(spacing: 12) {
                    // Total Spent Card
                    StandardCard {
                        VStack(spacing: 8) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Text("Total spent")
                                .font(DesignConstants.Typography.caption)
                                .foregroundColor(DesignConstants.Colors.textSecondary)

                            Text("$1,240")
                                .font(.custom("Roboto", size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                    }

                    // Bills Split Card
                    StandardCard {
                        VStack(spacing: 8) {
                            Image(systemName: "doc.text")
                                .font(.system(size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Text("Bills split")
                                .font(DesignConstants.Typography.caption)
                                .foregroundColor(DesignConstants.Colors.textSecondary)

                            Text("47")
                                .font(.custom("Roboto", size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }

            // Quick Actions
            VStack(spacing: DesignConstants.contentSpacing) {
                HStack {
                    Text("Quick Actions")
                        .font(DesignConstants.Typography.headline)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                        .fontWeight(.bold)
                    Spacer()
                }

                VStack(spacing: DesignConstants.contentSpacing) {
                    // Accounts Button
                    StandardCard {
                        Button(action: {
                            // Navigate to payment methods
                        }) {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .frame(width: 48, height: 48)
                                        .foregroundColor(DesignConstants.Colors.secondary)

                                    Image(systemName: "creditcard")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Accounts")
                                        .font(DesignConstants.Typography.body)
                                        .foregroundColor(DesignConstants.Colors.textPrimary)
                                        .fontWeight(.medium)

                                    Text("Manage accounts")
                                        .font(DesignConstants.Typography.caption)
                                        .foregroundColor(DesignConstants.Colors.textSecondary)
                                }

                                Spacer()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    // Transaction History Button
                    StandardCard {
                        Button(action: {
                            // Navigate to transaction history
                        }) {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .frame(width: 48, height: 48)
                                        .foregroundColor(DesignConstants.Colors.accent)

                                    Image(systemName: "doc.text")
                                        .font(.system(size: 24))
                                        .foregroundColor(DesignConstants.Colors.textPrimary)
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Transaction History")
                                        .font(DesignConstants.Typography.body)
                                        .foregroundColor(DesignConstants.Colors.textPrimary)
                                        .fontWeight(.medium)

                                    Text("View all your bills")
                                        .font(DesignConstants.Typography.caption)
                                        .foregroundColor(DesignConstants.Colors.textSecondary)
                                }

                                Spacer()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    // Achievements Button
                    StandardCard {
                        Button(action: {
                            // Navigate to achievements
                        }) {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .frame(width: 48, height: 48)
                                        .foregroundColor(DesignConstants.Colors.textPrimary)

                                    Image(systemName: "trophy")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Achievements")
                                        .font(DesignConstants.Typography.body)
                                        .foregroundColor(DesignConstants.Colors.textPrimary)
                                        .fontWeight(.medium)

                                    Text("3 badges earned")
                                        .font(DesignConstants.Typography.caption)
                                        .foregroundColor(DesignConstants.Colors.textSecondary)
                                }

                                Spacer()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding(EdgeInsets(top: DesignConstants.contentSpacing, leading: 0, bottom: 0, trailing: 0))
    }

    // MARK: - Friend Profile Content
    private var friendProfileContent: some View {
        VStack(spacing: DesignConstants.contentSpacing) {
            // Shared Bills
            VStack(spacing: DesignConstants.contentSpacing) {
                HStack {
                    Text("Shared Bills")
                        .font(DesignConstants.Typography.headline)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                        .fontWeight(.bold)
                    Spacer()
                }

                VStack(spacing: DesignConstants.contentSpacing) {
                    // Bill 1
                    StandardCard {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(DesignConstants.Colors.secondary)

                                Image(systemName: "doc.text")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Dinner at Pizza Place")
                                    .font(DesignConstants.Typography.body)
                                    .foregroundColor(DesignConstants.Colors.textPrimary)
                                    .fontWeight(.medium)

                                Text("Nov 5, 2025")
                                    .font(DesignConstants.Typography.caption)
                                    .foregroundColor(DesignConstants.Colors.textSecondary)
                            }

                            Spacer()

                            Text("$22.50")
                                .font(DesignConstants.Typography.body)
                                .foregroundColor(DesignConstants.Colors.danger)
                                .fontWeight(.bold)
                        }
                    }

                    // Bill 2
                    StandardCard {
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(DesignConstants.Colors.accent)

                                Image(systemName: "doc.text")
                                    .font(.system(size: 24))
                                    .foregroundColor(DesignConstants.Colors.textPrimary)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Coffee Shop")
                                    .font(DesignConstants.Typography.body)
                                    .foregroundColor(DesignConstants.Colors.textPrimary)
                                    .fontWeight(.medium)

                                Text("Nov 3, 2025")
                                    .font(DesignConstants.Typography.caption)
                                    .foregroundColor(DesignConstants.Colors.textSecondary)
                            }

                            Spacer()

                            Text("$8.50")
                                .font(DesignConstants.Typography.body)
                                .foregroundColor(DesignConstants.Colors.accent)
                                .fontWeight(.bold)
                        }
                    }
                }
            }

            // Activity Summary
            VStack(spacing: DesignConstants.contentSpacing) {
                HStack {
                    Text("Activity")
                        .font(DesignConstants.Typography.headline)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                        .fontWeight(.bold)
                    Spacer()
                }

                HStack(spacing: 12) {
                    // Bills Together Card
                    StandardCard {
                        VStack(spacing: 8) {
                            Image(systemName: "calendar")
                                .font(.system(size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Text("Bills together")
                                .font(DesignConstants.Typography.caption)
                                .foregroundColor(DesignConstants.Colors.textSecondary)

                            Text("12")
                                .font(.custom("Roboto", size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                    }

                    // Total Spent Card
                    StandardCard {
                        VStack(spacing: 8) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Text("Total spent")
                                .font(DesignConstants.Typography.caption)
                                .foregroundColor(DesignConstants.Colors.textSecondary)

                            Text("$245")
                                .font(.custom("Roboto", size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }

            // Mutual Contacts
            StandardCard(cornerRadius: DesignConstants.CornerRadius.large) {
                HStack(spacing: 12) {
                    Image(systemName: "person.2")
                        .font(.system(size: 24))
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    Text("You have 1 mutual iOS contact")
                        .font(DesignConstants.Typography.body)
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    Spacer()
                }
            }
        }
        .padding(EdgeInsets(top: DesignConstants.contentSpacing, leading: 0, bottom: 0, trailing: 0))
    }

    // MARK: - Non-Friend Profile Content
    private var nonFriendProfileContent: some View {
        VStack(spacing: DesignConstants.contentSpacing) {
            // About Section
            VStack(spacing: DesignConstants.contentSpacing) {
                HStack {
                    Text("About")
                        .font(DesignConstants.Typography.headline)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                        .fontWeight(.bold)
                    Spacer()
                }

                StandardCard(cornerRadius: DesignConstants.CornerRadius.large) {
                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            Image(systemName: "person.2")
                                .font(.system(size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Text("2 mutual friends")
                                .font(DesignConstants.Typography.body)
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Spacer()
                        }

                        HStack(spacing: 12) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 24))
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Text("Active on SplitBill")
                                .font(DesignConstants.Typography.body)
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Spacer()
                        }
                    }
                }
            }

            // Suggested Connection
            VStack(spacing: DesignConstants.contentSpacing) {
                HStack {
                    Text("Why you might know them")
                        .font(DesignConstants.Typography.headline)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                        .fontWeight(.bold)
                    Spacer()
                }

                StandardCard(cornerRadius: DesignConstants.CornerRadius.large) {
                    Text("You have mutual friends and shared contacts")
                        .font(DesignConstants.Typography.body)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(EdgeInsets(top: DesignConstants.contentSpacing, leading: 0, bottom: 0, trailing: 0))
    }
}

#Preview {
    UserProfileView(showUserProfile: .constant(true), userProfileFromSettings: .constant(false), showNotifications: .constant(false), userProfile: nil)
}