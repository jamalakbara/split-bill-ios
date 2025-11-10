//
//  NotificationsView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct NotificationsView: View {
    @Binding var showNotifications: Bool

    // Sample notifications data - matches the mockup exactly
    private let notifications: [AppNotification] = [
        AppNotification(
            id: 1,
            type: .payment,
            title: "Payment received",
            message: "Sarah paid you $45.50 for Dinner at Pizza Place",
            time: "2 hours ago",
            iconName: "dollarsign.circle",
            color: DesignConstants.Colors.accent,
            isRead: false
        ),
        AppNotification(
            id: 2,
            type: .reminder,
            title: "Payment reminder",
            message: "You owe Mike $28.00 for Movie Tickets",
            time: "5 hours ago",
            iconName: "doc.text",
            color: DesignConstants.Colors.danger,
            isRead: false
        ),
        AppNotification(
            id: 3,
            type: .group,
            title: "Added to group",
            message: "Cooper added you to 'Trip to Vegas'",
            time: "1 day ago",
            iconName: "person.3",
            color: DesignConstants.Colors.secondary,
            isRead: true
        ),
        AppNotification(
            id: 4,
            type: .payment,
            title: "Payment sent",
            message: "You paid Emma $67.25 for Grocery Shopping",
            time: "2 days ago",
            iconName: "dollarsign.circle",
            color: DesignConstants.Colors.accent,
            isRead: true
        ),
        AppNotification(
            id: 5,
            type: .reminder,
            title: "Settlement completed",
            message: "All bills with Jacob have been settled",
            time: "3 days ago",
            iconName: "doc.text",
            color: DesignConstants.Colors.textPrimary,
            isRead: true
        )
    ]

    private var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }

    var body: some View {
        ScreenContainer(
            title: nil,
            backgroundColor: DesignConstants.Colors.background,
            showBackButton: false,
            showEditButton: false,
            hasScrollView: true
        ) {
            LazyVStack(spacing: DesignConstants.contentSpacing) {
                // Simple Header
                headerSection

                // Unread Notifications Banner
                if unreadCount > 0 {
                    unreadNotificationsBanner
                }

                // Notifications List
                notificationsList

                // Bottom padding
                Color.clear
                    .frame(height: DesignConstants.verticalPadding)
            }
        }
    }

    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            // Title
            Text("Notifications")
                .font(DesignConstants.Typography.title1)
                .fontWeight(.bold)
                .foregroundColor(DesignConstants.Colors.textPrimary)

            Spacer()

            // Close button
            Button(action: {
                showNotifications = false
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(DesignConstants.Colors.textSecondary)
            }
            .frame(width: 32, height: 32)
        }
        .padding(.horizontal, DesignConstants.horizontalPadding)
        .padding(.vertical, 16)
    }

    // MARK: - Unread Notifications Banner
    private var unreadNotificationsBanner: some View {
        StandardCard(cornerRadius: DesignConstants.CornerRadius.large) {
            HStack(spacing: 12) {
                // Bell Icon
                Image(systemName: "bell")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                // Unread Count Text
                Text("You have \(unreadCount) unread notification\(unreadCount > 1 ? "s" : "")")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                Spacer()
            }
            .padding(DesignConstants.cardPadding)
        }
        .background(
            Color.white.opacity(0.1)
                .cornerRadius(DesignConstants.CornerRadius.large)
                .overlay(
                    RoundedRectangle(cornerRadius: DesignConstants.CornerRadius.large)
                        .stroke(Color.white.opacity(0.2), lineWidth: 2)
                )
        )
    }

    // MARK: - Notifications List
    private var notificationsList: some View {
        ForEach(notifications) { notification in
            notificationRow(notification)
        }
    }

    // MARK: - Individual Notification Row
    private func notificationRow(_ notification: AppNotification) -> some View {
        StandardCard(cornerRadius: DesignConstants.CornerRadius.large) {
            HStack(spacing: 12) {
                // Notification Icon
                ZStack {
                    Circle()
                        .frame(width: 48, height: 48)
                        .foregroundColor(notification.color)

                    Image(systemName: notification.iconName)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                }

                // Notification Content
                VStack(alignment: .leading, spacing: 4) {
                    // Title Row with unread indicator
                    HStack {
                        Text(notification.title)
                            .font(DesignConstants.Typography.body)
                            .foregroundColor(DesignConstants.Colors.textPrimary)
                            .fontWeight(.medium)

                        Spacer()

                        // Unread indicator dot
                        if !notification.isRead {
                            Circle()
                                .frame(width: 8, height: 8)
                                .foregroundColor(DesignConstants.Colors.danger)
                        }
                    }

                    // Message
                    Text(notification.message)
                        .font(DesignConstants.Typography.callout)
                        .foregroundColor(DesignConstants.Colors.textSecondary.opacity(0.7))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)

                    // Time
                    Text(notification.time)
                        .font(DesignConstants.Typography.caption)
                        .foregroundColor(DesignConstants.Colors.textSecondary.opacity(0.5))
                }
            }
        }
        .background(
            !notification.isRead ?
            DesignConstants.Colors.accent.opacity(0.1) :
            Color.clear
        )
    }

    // MARK: - Empty State
    private var emptyState: some View {
        VStack(spacing: DesignConstants.contentSpacing) {
            // Bell Icon
            Image(systemName: "bell")
                .font(.system(size: 64, weight: .light))
                .foregroundColor(DesignConstants.Colors.textPrimary.opacity(0.2))

            // No notifications text
            Text("No notifications yet")
                .font(DesignConstants.Typography.body)
                .foregroundColor(DesignConstants.Colors.textPrimary.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 48)
        .padding(.bottom, 48)
    }
}

#Preview {
    NotificationsView(showNotifications: .constant(true))
}