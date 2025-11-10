//
//  GroupDetailView.swift
//  split bill
//
//  Created by Chairil Akbar on 10/11/25.
//

import SwiftUI

struct GroupDetailView: View {
    let group: GroupModel?
    @Binding var showGroupDetail: Bool
    @Binding var showGroups: Bool
    @Binding var showNotifications: Bool
    @Binding var showSettings: Bool

    let members = mockGroupMembers
    let bills = mockGroupBills

    var displayGroup: GroupModel {
        group ?? GroupModel(id: 1, name: "Roommates", members: 4, balance: 0, color: "#f77f00", emoji: "🐻")
    }

    var body: some View {
        ScreenContainer(
            title: nil,
            showBackButton: true,
            showEditButton: true,
            backButtonAction: {
                showGroupDetail = false
                showGroups = true
            },
            editButtonAction: {
                // TODO: Navigate to edit group
            },
            editButtonIcon: "pencil",
            hasScrollView: true,
            customTopPadding: nil,
            headerType: .detail,
            customHeaderContent: HeaderContentView(
                type: .groupDetail(
                    groupIcon: displayGroup.emoji,
                    groupName: displayGroup.name,
                    memberCount: displayGroup.members,
                    editButtonAction: nil
                )
            ),
            headerHeight: 280
        ) {
            VStack(spacing: DesignConstants.sectionSpacing) {
                // Group Statistics
                VStack(alignment: .leading, spacing: DesignConstants.contentSpacing) {
                    Text("Group Stats")
                        .font(DesignConstants.Typography.headline)
                        .fontWeight(.bold)
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    HStack(spacing: DesignConstants.contentSpacing) {
                        // Total Bills Card
                        StandardCard {
                            VStack(spacing: 8) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(DesignConstants.Colors.textPrimary)

                                Text("Total bills")
                                    .font(DesignConstants.Typography.caption)
                                    .foregroundColor(DesignConstants.Colors.textSecondary)

                                Text("28")
                                    .font(DesignConstants.Typography.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(DesignConstants.Colors.textPrimary)
                            }
                            .frame(maxWidth: .infinity)
                        }

                        // Total Spent Card
                        StandardCard {
                            VStack(spacing: 8) {
                                Image(systemName: "activity")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(DesignConstants.Colors.textPrimary)

                                Text("Total spent")
                                    .font(DesignConstants.Typography.caption)
                                    .foregroundColor(DesignConstants.Colors.textSecondary)

                                Text("$856")
                                    .font(DesignConstants.Typography.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(DesignConstants.Colors.textPrimary)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }

                // Recent Group Bills
                VStack(alignment: .leading, spacing: DesignConstants.contentSpacing) {
                    Text("Recent Bills")
                        .font(DesignConstants.Typography.headline)
                        .fontWeight(.bold)
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    VStack(spacing: DesignConstants.contentSpacing) {
                        ForEach(bills) { bill in
                            StandardCard {
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(Color(hex: bill.color))
                                            .frame(width: 48, height: 48)
                                            .overlay(
                                                Circle()
                                                    .stroke(DesignConstants.Colors.textPrimary, lineWidth: 3)
                                            )

                                        Image(systemName: "doc.text")
                                            .font(.system(size: 20, weight: .medium))
                                            .foregroundColor(.white)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(bill.title)
                                            .font(DesignConstants.Typography.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(DesignConstants.Colors.textPrimary)

                                        Text(bill.date)
                                            .font(DesignConstants.Typography.caption)
                                            .foregroundColor(DesignConstants.Colors.textSecondary)
                                    }

                                    Spacer()

                                    Text("$\(bill.amount, specifier: "%.2f")")
                                        .font(DesignConstants.Typography.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(DesignConstants.Colors.textPrimary)
                                }
                            }
                        }
                    }
                }

                // Members List
                VStack(alignment: .leading, spacing: DesignConstants.contentSpacing) {
                    Text("Members")
                        .font(DesignConstants.Typography.headline)
                        .fontWeight(.bold)
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    VStack(spacing: DesignConstants.contentSpacing) {
                        ForEach(members) { member in
                            StandardCard {
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(DesignConstants.Colors.accent)
                                            .frame(width: 48, height: 48)
                                            .overlay(
                                                Circle()
                                                    .stroke(DesignConstants.Colors.textPrimary, lineWidth: 3)
                                            )

                                        Text(member.avatar)
                                            .font(DesignConstants.Typography.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(DesignConstants.Colors.textPrimary)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(member.name)
                                            .font(DesignConstants.Typography.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(DesignConstants.Colors.textPrimary)

                                        if member.owed > 0 {
                                            Text(member.owes ? "Owes $\(member.owed, specifier: "%.2f")" : "Gets back $\(member.owed, specifier: "%.2f")")
                                                .font(DesignConstants.Typography.caption)
                                                .foregroundColor(member.owes ? DesignConstants.Colors.danger : DesignConstants.Colors.accent)
                                        } else {
                                            Text("Settled up")
                                                .font(DesignConstants.Typography.caption)
                                                .foregroundColor(DesignConstants.Colors.textSecondary)
                                        }
                                    }

                                    Spacer()
                                }
                            }
                        }
                    }
                }

                // Leave Group Button
                PrimaryButton(
                    text: "Leave Group",
                    icon: "person.badge.minus",
                    backgroundColor: DesignConstants.Colors.danger,
                    borderColor: DesignConstants.Colors.textPrimary,
                    action: {
                        // TODO: Handle leave group
                    }
                )
            }
        }
    }
}

#Preview {
    GroupDetailView(
        group: mockGroups.first,
        showGroupDetail: .constant(true),
        showGroups: .constant(false),
        showNotifications: .constant(false),
        showSettings: .constant(false)
    )
}