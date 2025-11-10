//
//  HeaderContentView.swift
//  split bill
//
//  Created by Chairil Akbar on 10/11/25.
//

import SwiftUI

// MARK: - Header Content Types
enum HeaderContentType {
    case simple(title: String, subtitle: String?)
    case groupDetail(groupIcon: String, groupName: String, memberCount: Int, editButtonAction: (() -> Void)?)
    case userProfile(userName: String, avatarUrl: String?, stats: String?)
    case custom(content: AnyView)
}

// MARK: - Header Content View
struct HeaderContentView: View {
    let type: HeaderContentType
    let foregroundColor: Color

    init(type: HeaderContentType, foregroundColor: Color = .white) {
        self.type = type
        self.foregroundColor = foregroundColor
    }

    var body: some View {
        VStack(spacing: 0) {
            switch type {
            case .simple(let title, let subtitle):
                simpleHeaderContent(title: title, subtitle: subtitle)
            case .groupDetail(let groupIcon, let groupName, let memberCount, let editButtonAction):
                groupDetailHeaderContent(icon: groupIcon, name: groupName, memberCount: memberCount, editAction: editButtonAction)
            case .userProfile(let userName, let avatarUrl, let stats):
                userProfileHeaderContent(userName: userName, avatarUrl: avatarUrl, stats: stats)
            case .custom(let content):
                content
            }
        }
        .foregroundColor(foregroundColor)
    }

    // MARK: - Simple Header Content
    private func simpleHeaderContent(title: String, subtitle: String?) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.custom("Roboto", size: 32))
                .fontWeight(.black)
                .multilineTextAlignment(.center)

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(DesignConstants.Typography.body)
                    .opacity(0.8)
                    .multilineTextAlignment(.center)
            }
        }
    }

    // MARK: - Group Detail Header Content
    private func groupDetailHeaderContent(icon: String, name: String, memberCount: Int, editAction: (() -> Void)?) -> some View {
        VStack(spacing: 16) {
            // Group Icon Section
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: "#f77f00"))
                        .frame(width: 112, height: 112)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 4)
                        )

                    Text(icon)
                        .font(.system(size: 48))
                }

                Text(name)
                    .font(.custom("Roboto", size: 32))
                    .fontWeight(.black)

                Text("\(memberCount) members")
                    .font(DesignConstants.Typography.body)
                    .opacity(0.8)
            }
            .padding(.vertical, 16)

            // Edit Group Button
            if let editAction = editAction {
                Button(action: editAction) {
                    HStack(spacing: 8) {
                        Image(systemName: "pencil")
                            .font(.system(size: 20, weight: .medium))

                        Text("Edit Group")
                            .font(DesignConstants.Typography.body)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color(hex: "#f77f00"))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(radius: 8)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

    // MARK: - User Profile Header Content
    private func userProfileHeaderContent(userName: String, avatarUrl: String?, stats: String?) -> some View {
        VStack(spacing: 16) {
            // User Avatar
            AsyncImage(url: URL(string: avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Circle()
                    .fill(foregroundColor.opacity(0.3))
                    .overlay(
                        Text(String(userName.prefix(1)))
                            .font(.custom("Roboto", size: 32))
                            .fontWeight(.bold)
                            .foregroundColor(foregroundColor)
                    )
            }
            .frame(width: 96, height: 96)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 4)
            )

            // User Info
            VStack(spacing: 4) {
                Text(userName)
                    .font(.custom("Roboto", size: 24))
                    .fontWeight(.bold)

                if let stats = stats {
                    Text(stats)
                        .font(DesignConstants.Typography.body)
                        .opacity(0.8)
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Simple Header Preview
        HeaderContentView(
            type: .simple(title: "Dashboard", subtitle: "Welcome back!")
        )
        .padding()
        .background(Color(hex: "#003049"))

        // Group Detail Header Preview
        HeaderContentView(
            type: .groupDetail(
                groupIcon: "🐻",
                groupName: "Roommates",
                memberCount: 4,
                editButtonAction: { print("Edit tapped") }
            )
        )
        .padding()
        .background(Color(hex: "#003049"))

        // User Profile Header Preview
        HeaderContentView(
            type: .userProfile(
                userName: "Sarah Chen",
                avatarUrl: nil,
                stats: "Active member • 28 bills"
            )
        )
        .padding()
        .background(Color(hex: "#003049"))
    }
}