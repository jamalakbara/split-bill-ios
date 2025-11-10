import SwiftUI

struct GroupsView: View {
    @Binding var showGroups: Bool
    @Binding var showNotifications: Bool
    @Binding var showGroupDetail: Bool
    @Binding var selectedGroup: GroupModel?
    @Binding var userProfileFromSettings: Bool
    @Binding var showUserProfile: Bool
    @Binding var showSettings: Bool

    var groups = mockGroups

    var body: some View {
        ZStack {
            // Main content with ScreenContainer
            ScreenContainer(
                title: "Groups",
                showBackButton: true,
                showEditButton: true,
                backButtonAction: {
                    showGroups = false
                },
                editButtonAction: {
                    showNotifications = true
                },
                editButtonIcon: "bell",
                hasScrollView: true,
                headerType: .simple
            ) {
                VStack(spacing: DesignConstants.contentSpacing) {
                    // Create Group Button
                    PrimaryButton(
                        text: "Create New Group",
                        icon: "plus",
                        action: {
                            // TODO: Navigate to create group
                        }
                    )

                    // Groups List
                    VStack(alignment: .leading, spacing: DesignConstants.contentSpacing) {
                        // Section Title
                        Text("Your Groups")
                            .font(DesignConstants.Typography.headline)
                            .fontWeight(.bold)
                            .foregroundColor(DesignConstants.Colors.textPrimary)

                        // Group Cards
                        ForEach(groups) { group in
                            Button(action: {
                                selectedGroup = group
                                showGroupDetail = true
                                showGroups = false
                            }) {
                                StandardCard {
                                    VStack(spacing: 12) {
                                        // Group info row
                                        HStack {
                                            // Group icon
                                            HStack(spacing: 12) {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .fill(Color(hex: group.color))
                                                        .frame(width: 56, height: 56)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(DesignConstants.Colors.textPrimary, lineWidth: 3)
                                                        )

                                                    Text(group.emoji)
                                                        .font(.system(size: 24))
                                                }

                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text(group.name)
                                                        .font(DesignConstants.Typography.body)
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(DesignConstants.Colors.textPrimary)

                                                    Text("\(group.members) members")
                                                        .font(DesignConstants.Typography.caption)
                                                        .foregroundColor(DesignConstants.Colors.textSecondary)
                                                }
                                            }

                                            Spacer()

                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 20, weight: .medium))
                                                .foregroundColor(DesignConstants.Colors.textSecondary.opacity(0.5))
                                        }

                                        // Balance info
                                        HStack {
                                            Text("Your balance")
                                                .font(DesignConstants.Typography.caption)
                                                .foregroundColor(DesignConstants.Colors.textSecondary.opacity(0.7))

                                            Spacer()

                                            if group.balance == 0 {
                                                Text("Settled up!")
                                                    .font(DesignConstants.Typography.body)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(DesignConstants.Colors.textPrimary)
                                            } else if group.balance > 0 {
                                                Text("+$\(abs(group.balance), specifier: "%.2f")")
                                                    .font(DesignConstants.Typography.body)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(DesignConstants.Colors.accent)
                                            } else {
                                                Text("-$\(abs(group.balance), specifier: "%.2f")")
                                                    .font(DesignConstants.Typography.body)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(DesignConstants.Colors.danger)
                                            }
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(DesignConstants.Colors.background)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }

                    // Bottom padding for safe area
                    Color.clear
                        .frame(height: 100)
                }
            }

            // Bottom Navigation (same as MainScreenView)
            VStack {
                Spacer()
                HStack {
                    NavigationTabButton(
                        icon: "house.fill",
                        text: "Home",
                        isActive: false,
                        action: {
                            showGroups = false
                        }
                    )

                    Spacer()

                    NavigationTabButton(
                        icon: "person.2",
                        text: "Groups",
                        isActive: true,
                        action: {}
                    )

                    Spacer()

                    // Placeholder space for floating button
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: 56, height: 76)

                    Spacer()

                    NavigationTabButton(
                        icon: "person.3",
                        text: "People",
                        isActive: false,
                        activeColor: DesignConstants.Colors.secondary,
                        inactiveColor: DesignConstants.Colors.primary,
                        action: {
                            showGroups = false
                            // Navigate to friends
                        }
                    )

                    Spacer()

                    NavigationTabButton(
                        icon: "gearshape",
                        text: "Settings",
                        action: {
                            showGroups = false
                            showSettings = true
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
            .overlay(
                // Floating Add button (same as MainScreenView)
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
                            action: {
                                // TODO: Navigate to create group
                            }
                        )
                        Spacer()
                    }
                    .padding(.bottom, 48) // Halfway above the navbar (20px navbar padding + 28px offset)
                }
                .ignoresSafeArea(edges: .bottom)
            )
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    GroupsView(
        showGroups: .constant(true),
        showNotifications: .constant(false),
        showGroupDetail: .constant(false),
        selectedGroup: .constant(nil),
        userProfileFromSettings: .constant(false),
        showUserProfile: .constant(false),
        showSettings: .constant(false)
    )
}