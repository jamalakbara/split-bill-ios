import SwiftUI

struct GroupsView: View {
    @Binding var showGroupDetail: Bool
    @Binding var selectedGroup: GroupModel?

    var groups = mockGroups

    var body: some View {
        ScreenContainer(
            title: "Groups",
            showBackButton: false,
            showEditButton: true,
                editButtonAction: {
                    // Handle notifications - this should be handled by parent view
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

                    // Bottom padding for content
                    Color.clear
                        .frame(height: 20)
                }
            }
        }
    }

#Preview {
    GroupsView(
        showGroupDetail: .constant(false),
        selectedGroup: .constant(nil)
    )
}