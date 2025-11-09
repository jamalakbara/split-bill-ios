//
//  MainScreenView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct MainScreenView: View {
    @Binding var showViewBill: Bool
    @Binding var selectedBill: RecentBill?

    let recentBills = [
        RecentBill(
            id: 1,
            title: "Dinner at Pizza Place",
            date: "Nov 5, 2025",
            amount: 45.50,
            type: "owe",
            friend: "Sarah"
        ),
        RecentBill(
            id: 2,
            title: "Movie Tickets",
            date: "Nov 4, 2025",
            amount: 28.00,
            type: "owes",
            friend: "Mike"
        ),
        RecentBill(
            id: 3,
            title: "Grocery Shopping",
            date: "Nov 2, 2025",
            amount: 67.25,
            type: "owe",
            friend: "Emma"
        )
    ]

    var body: some View {
        ZStack {
            // Background
            DesignConstants.Colors.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hi, Stamboel! 👋")
                                .font(.custom("Roboto", size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }

                        Spacer()

                        // Notification bell button
                        CircularIconButton(
                            icon: "bell",
                            action: {
                                // Notification action
                            }
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 48)
                    .padding(.bottom, 24)

                    // Balance Cards
                    HStack(spacing: 16) {
                        // You owe card
                        VStack(alignment: .leading, spacing: 8) {
                            Image(systemName: "arrow.down.right")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.white)

                            Text("You owe")
                                .font(.custom("Roboto", size: 14))
                                .foregroundColor(.white.opacity(0.9))

                            Text("$112.75")
                                .font(.custom("Roboto", size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color(hex: "#d62828"))
                                .stroke(Color.white, lineWidth: 4)
                        )

                        // Owed to you card
                        VStack(alignment: .leading, spacing: 8) {
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.white)

                            Text("Owed to you")
                                .font(.custom("Roboto", size: 14))
                                .foregroundColor(.white.opacity(0.9))

                            Text("$28.00")
                                .font(.custom("Roboto", size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color(hex: "#fcbf49"))
                                .stroke(Color.white, lineWidth: 4)
                        )
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
                .background(
                    Color(hex: "#003049")
                        .cornerRadius(48, corners: [.bottomLeft, .bottomRight])
                        .ignoresSafeArea(edges: .top)
                )
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)

                // Recent Bills
                ContentContainer(hasScrollView: true) {
                    VStack(spacing: DesignConstants.contentSpacing) {
                        HStack {
                            Text("Recent Bills")
                                .font(DesignConstants.Typography.headline)
                                .fontWeight(.bold)
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Spacer()
                        }

                        ForEach(recentBills, id: \.id) { bill in
                            Button(action: {
                                selectedBill = bill
                                showViewBill = true
                            }) {
                                StandardCard {
                                    HStack(spacing: 12) {
                                        // Bill icon
                                        ZStack {
                                            Circle()
                                                .frame(width: 48, height: 48)
                                                .foregroundColor(bill.type == "owe" ? DesignConstants.Colors.danger : DesignConstants.Colors.accent)
                                                .overlay(
                                                    Circle()
                                                        .stroke(DesignConstants.Colors.textPrimary, lineWidth: DesignConstants.BorderWidth.medium)
                                                )

                                            Image(systemName: "doc.text.fill")
                                                .font(.system(size: 24))
                                                .foregroundColor(.white)
                                        }

                                        // Bill info
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(bill.title)
                                                .font(DesignConstants.Typography.body)
                                                .foregroundColor(DesignConstants.Colors.textPrimary)

                                            Text("\(bill.type == "owe" ? "You owe" : "Owes you") \(bill.friend)")
                                                .font(DesignConstants.Typography.callout)
                                                .foregroundColor(DesignConstants.Colors.textSecondary)
                                        }

                                        Spacer()

                                        // Amount and date
                                        VStack(alignment: .trailing, spacing: 2) {
                                            Text(String(format: "$%.2f", bill.amount))
                                                .font(DesignConstants.Typography.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(bill.type == "owe" ? DesignConstants.Colors.danger : DesignConstants.Colors.accent)

                                            Text(bill.date)
                                                .font(DesignConstants.Typography.caption)
                                                .foregroundColor(DesignConstants.Colors.textSecondary)
                                        }
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }

                        // Bottom padding for safe area
                        Color.clear
                            .frame(height: 100)
                    }
                }
            }

            // Bottom Navigation (placeholder)
            VStack {
                Spacer()
                HStack {
                    NavigationTabButton(
                        icon: "house.fill",
                        text: "Home",
                        isActive: true,
                        action: {}
                    )

                    Spacer()

                    NavigationTabButton(
                        icon: "person.2",
                        text: "Groups",
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
                // Floating Add button
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
        }
    }
}

#Preview {
    MainScreenView(showViewBill: .constant(false), selectedBill: .constant(nil))
}
