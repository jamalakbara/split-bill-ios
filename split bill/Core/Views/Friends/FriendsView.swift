//
//  FriendsView.swift
//  split bill
//
//  Created by Chairil Akbar on 10/11/25.
//

import SwiftUI

struct FriendsView: View {
    @Binding var showFriends: Bool
    @Binding var showUserProfile: Bool
    @Binding var selectedUserProfile: UserProfile?
    @Binding var showNotifications: Bool

    @State private var selectedFriends: [Friend] = []
    @State private var searchQuery = ""

    private var filteredFriends: [Friend] {
        Friend.allFriends.filter { friend in
            searchQuery.isEmpty || friend.name.lowercased().contains(searchQuery.lowercased())
        }
    }

    private var filteredSuggestedPeople: [Friend] {
        Friend.suggestedPeople.filter { person in
            searchQuery.isEmpty || person.name.lowercased().contains(searchQuery.lowercased())
        }
    }

    var body: some View {
        ScreenContainer(
            title: "Friends",
            backgroundColor: DesignConstants.Colors.background,
            showBackButton: true,
            showEditButton: true,
            backButtonAction: {
                showFriends = false
            },
            editButtonAction: {
                showNotifications = true
            },
            editButtonIcon: "bell",
            hasScrollView: true
        ) {
            VStack(spacing: DesignConstants.contentSpacing) {
                // Selected Friends Row
                if !selectedFriends.isEmpty {
                    selectedFriendsRow
                }

                // Search Bar
                searchBar

                // Friends Section
                friendsSection

                // Suggested People Section
                suggestedPeopleSection

                // Bottom padding
                Color.clear
                    .frame(height: 100)
            }
        }
        .overlay(
            // Bottom Navigation (matches MainScreenView exactly)
            VStack {
                Spacer()
                HStack {
                    NavigationTabButton(
                        icon: "house.fill",
                        text: "Home",
                        action: {
                            showFriends = false
                        }
                    )

                    Spacer()

                    NavigationTabButton(
                        icon: "person.2",
                        text: "Groups",
                        action: {
                            showFriends = false
                        }
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
                        isActive: true,
                        activeColor: DesignConstants.Colors.secondary,
                        inactiveColor: DesignConstants.Colors.primary,
                        action: {}
                    )

                    Spacer()

                    NavigationTabButton(
                        icon: "gearshape",
                        text: "Settings",
                        action: {}
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
                // Floating Add button (matches MainScreenView exactly)
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
                            action: {}
                        )
                        Spacer()
                    }
                    .padding(.bottom, 48) // Halfway above the navbar (20px navbar padding + 28px offset)
                }
                .ignoresSafeArea(edges: .bottom)
            )
        )
    }

    // MARK: - Selected Friends Row
    private var selectedFriendsRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(selectedFriends) { friend in
                    VStack(spacing: 4) {
                        ZStack(alignment: .topTrailing) {
                            AsyncImage(url: URL(string: friend.image)) { image in
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
                                    .stroke(DesignConstants.Colors.textPrimary, lineWidth: 4)
                            )

                            Button(action: {
                                removeFriend(friend)
                            }) {
                                ZStack {
                                    Circle()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(DesignConstants.Colors.danger)
                                        .overlay(
                                            Circle()
                                                .stroke(DesignConstants.Colors.white, lineWidth: 2)
                                        )

                                    Image(systemName: "xmark")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white)
                                }
                            }
                            .offset(x: 4, y: -4)
                            .buttonStyle(PlainButtonStyle())
                        }

                        Text(friend.name)
                            .font(.system(size: 12))
                            .foregroundColor(DesignConstants.Colors.textPrimary)
                    }
                }
            }
            .padding(.bottom, 8)
        }
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack {
            HStack {
                TextField("Search name, group", text: $searchQuery)
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textPrimary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(DesignConstants.Colors.textPrimary, lineWidth: 4)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 0, x: 3, y: 3)
            )

            Button(action: {}) {
                ZStack {
                    Circle()
                        .frame(width: 52, height: 52)
                        .foregroundColor(DesignConstants.Colors.accent)
                        .overlay(
                            Circle()
                                .stroke(DesignConstants.Colors.textPrimary, lineWidth: 3)
                        )

                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    // MARK: - Friends Section
    private var friendsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Friends")
                .font(DesignConstants.Typography.headline)
                .fontWeight(.bold)
                .foregroundColor(DesignConstants.Colors.textPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(filteredFriends) { friend in
                        if friend.id == filteredFriends.first?.id {
                            Button(action: {
                                navigateToProfile(friend)
                            }) {
                                VStack(spacing: 8) {
                                    AsyncImage(url: URL(string: friend.image)) { image in
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
                                            .stroke(DesignConstants.Colors.textPrimary, lineWidth: 4)
                                    )

                                    Text(friend.name)
                                        .font(DesignConstants.Typography.callout)
                                        .foregroundColor(DesignConstants.Colors.textPrimary)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.leading, 4) // Add small margin for first icon
                        } else {
                            Button(action: {
                                navigateToProfile(friend)
                            }) {
                                VStack(spacing: 8) {
                                    AsyncImage(url: URL(string: friend.image)) { image in
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
                                            .stroke(DesignConstants.Colors.textPrimary, lineWidth: 4)
                                    )

                                    Text(friend.name)
                                        .font(DesignConstants.Typography.callout)
                                        .foregroundColor(DesignConstants.Colors.textPrimary)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    // MARK: - Suggested People Section
    private var suggestedPeopleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Suggested People")
                    .font(DesignConstants.Typography.headline)
                    .fontWeight(.bold)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                Spacer()
            }

            VStack(spacing: DesignConstants.contentSpacing) {
                ForEach(filteredSuggestedPeople) { person in
                    StandardCard {
                        HStack(spacing: 12) {
                            Button(action: {
                                navigateToProfile(person)
                            }) {
                                HStack(spacing: 12) {
                                    AsyncImage(url: URL(string: person.image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Circle()
                                            .frame(width: 48, height: 48)
                                            .foregroundColor(DesignConstants.Colors.textSecondary.opacity(0.3))
                                    }
                                    .frame(width: 48, height: 48)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(DesignConstants.Colors.textPrimary, lineWidth: 4)
                                    )

                                    Text(person.name)
                                        .font(DesignConstants.Typography.body)
                                        .foregroundColor(DesignConstants.Colors.textPrimary)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())

                            Spacer()

                            Button(action: {
                                toggleFriend(person)
                            }) {
                                ZStack {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(DesignConstants.Colors.accent)
                                        .overlay(
                                            Circle()
                                                .stroke(DesignConstants.Colors.textPrimary, lineWidth: 2)
                                        )

                                    Image(systemName: "person.badge.plus")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(DesignConstants.Colors.textPrimary)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
    }

    // MARK: - Actions
    private func toggleFriend(_ friend: Friend) {
        if selectedFriends.contains(where: { $0.id == friend.id }) {
            selectedFriends.removeAll { $0.id == friend.id }
        } else {
            selectedFriends.append(friend)
        }
    }

    private func removeFriend(_ friend: Friend) {
        selectedFriends.removeAll { $0.id == friend.id }
    }

    private func navigateToProfile(_ friend: Friend) {
        selectedUserProfile = UserProfile(
            id: friend.id,
            name: friend.name,
            image: friend.image
        )
        showFriends = false
        showUserProfile = true
    }
}

#Preview {
    FriendsView(
        showFriends: .constant(true),
        showUserProfile: .constant(false),
        selectedUserProfile: .constant(nil),
        showNotifications: .constant(false)
    )
}