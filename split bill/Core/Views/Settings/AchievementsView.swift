//
//  AchievementsView.swift
//  split bill
//
//  Created by Chairil Akbar on 10/11/25.
//

import SwiftUI

struct AchievementsView: View {
    @Binding var showAchievements: Bool
    @Binding var showSettings: Bool
    @Binding var showNotifications: Bool

    let achievements = Achievement.mockAchievements

    var body: some View {
        ScreenContainer(
            title: "Achievements",
            backgroundColor: Color(hex: "#eae2b7"),
            showBackButton: true,
            showEditButton: true,
            backButtonAction: {
                showAchievements = false
                showSettings = true
            },
            editButtonAction: {
                showNotifications = true
            },
            editButtonIcon: "bell",
            hasScrollView: true,
            customTopPadding: nil,
            headerType: .custom,
            customHeaderContent: HeaderContentView(
                type: .custom(content: AnyView(headerContent))
            ),
            headerHeight: 280
        ) {
            VStack(spacing: 16) {
                // Achievements List
                achievementsList

                // Bottom padding
                Color.clear
                    .frame(height: 32)
            }
        }
    }

    // MARK: - Header Content (for custom header)
    private var headerContent: some View {
        VStack(spacing: 0) {
            // Top padding to avoid overlapping header buttons (56px button height + 24px header top padding + 16px spacing)
            Color.clear
                .frame(height: 80)

            // Stats Cards Grid
            HStack(spacing: 12) {
                // Unlocked Count Card
                VStack(spacing: 8) {
                    Image(systemName: "trophy")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(Color(hex: "#003049"))

                    Text("\(achievements.unlockedCount)/\(achievements.count)")
                        .font(.system(size: 24, weight: .heavy))
                        .foregroundColor(Color(hex: "#003049"))

                    Text("Unlocked")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(hex: "#003049").opacity(0.7))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    Color(hex: "#fcbf49")
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4)
                        )
                        .shadow(color: Color.white.opacity(0.3), radius: 3, x: 3, y: 3)
                )

                // Total Points Card
                VStack(spacing: 8) {
                    Image(systemName: "star")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)

                    Text("\(achievements.totalPoints)")
                        .font(.system(size: 24, weight: .heavy))
                        .foregroundColor(.white)

                    Text("Total Points")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    Color(hex: "#f77f00")
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4)
                        )
                        .shadow(color: Color.white.opacity(0.3), radius: 3, x: 3, y: 3)
                )
            }
        }
    }

    // MARK: - Achievements List
    private var achievementsList: some View {
        LazyVStack(spacing: 16) {
            ForEach(achievements) { achievement in
                achievementCard(achievement)
            }
        }
    }

    // MARK: - Individual Achievement Card
    private func achievementCard(_ achievement: Achievement) -> some View {
        StandardCard {
            HStack(alignment: .top, spacing: 12) {
                // Achievement Icon
                ZStack {
                    Circle()
                        .frame(width: 56, height: 56)
                        .foregroundColor(achievement.unlocked ? Color(hex: achievement.color) : Color(hex: "#d1d5db"))
                        .overlay(
                            Circle()
                                .stroke(Color(hex: "#003049"), lineWidth: 3)
                        )
                        .scaleEffect(achievement.unlocked ? 1.05 : 1.0)
                        .opacity(achievement.unlocked ? 1.0 : 0.7)

                    Image(systemName: achievement.iconName)
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(achievement.unlocked ? .white : .gray.opacity(0.6))
                }

                // Achievement Content
                VStack(alignment: .leading, spacing: 8) {
                    // Title and Status Badge
                    HStack(alignment: .top, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(achievement.title)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(hex: "#003049"))

                            Text(achievement.description)
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#003049").opacity(0.6))
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                        }

                        Spacer()

                        // Unlocked Badge
                        if achievement.unlocked {
                            ZStack {
                                Circle()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(Color(hex: "#fcbf49"))
                                    .overlay(
                                        Circle()
                                            .stroke(Color(hex: "#003049"), lineWidth: 2)
                                    )

                                Image(systemName: "trophy")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color(hex: "#003049"))
                            }
                        }
                    }

                    // Progress Bar (for locked achievements)
                    if !achievement.unlocked {
                        VStack(spacing: 8) {
                            HStack {
                                Text("\(achievement.progress) / \(achievement.total)")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(hex: "#003049"))

                                Spacer()

                                Text("\(Int(achievement.progressPercentage * 100))%")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(hex: "#003049").opacity(0.6))
                            }

                            // Progress Bar
                            ZStack(alignment: .leading) {
                                // Background
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(height: 12)
                                    .foregroundColor(Color.gray.opacity(0.2))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color(hex: "#003049"), lineWidth: 2)
                                    )

                                // Progress
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(height: 12)
                                    .foregroundColor(Color(hex: achievement.color))
                                    .frame(width: progressWidth(for: achievement))
                                    .animation(.easeInOut(duration: 0.5), value: achievement.progress)
                            }
                        }
                    }

                    // Reward Badge (for unlocked achievements)
                    if achievement.unlocked, let reward = achievement.reward {
                        HStack {
                            Text("🎉 \(reward)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color(hex: "#003049"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(
                                    Color(hex: "#fcbf49")
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(hex: "#003049"), lineWidth: 2)
                                        )
                                )
                            Spacer()
                        }
                        .padding(.top, 4)
                    }
                }
            }
        }
        .opacity(achievement.unlocked ? 1.0 : 0.7)
    }

    // MARK: - Helper Functions
    private func progressWidth(for achievement: Achievement) -> CGFloat {
        // Use a fixed width calculation that doesn't require UIScreen.main
        let cardContentWidth: CGFloat = 280 // Estimated content width
        return cardContentWidth * achievement.progressPercentage
    }
}

#Preview {
    AchievementsView(
        showAchievements: .constant(true),
        showSettings: .constant(false),
        showNotifications: .constant(false)
    )
}
