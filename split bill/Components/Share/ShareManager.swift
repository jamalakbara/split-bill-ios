//
//  ShareManager.swift
//  split bill
//
//  Created by Chairil Akbar on 11/11/25.
//

import SwiftUI

struct ShareManager {
    static func shareBill(_ bill: RecentBill) -> String {
        return """
        💰 Bill Details 💰

        📝 \(bill.title)
        👤 \(bill.type == "owe" ? "You owe" : "Owes you") \(bill.friend)
        💵 $\(String(format: "%.2f", bill.amount))
        📅 \(bill.date)

        Shared from Split Bill app
        """
    }

    static func shareGroup(_ group: GroupModel) -> String {
        let balanceText: String
        if group.balance == 0 {
            balanceText = "Settled up!"
        } else if group.balance > 0 {
            balanceText = "+$\(String(format: "%.2f", group.balance))"
        } else {
            balanceText = "-$\(String(format: "%.2f", abs(group.balance)))"
        }

        return """
        👥 Group Details 👥

        📌 \(group.name)
        👥 \(group.members) members
        💰 Your balance: \(balanceText)

        Shared from Split Bill app
        """
    }

    static func shareAchievement(_ achievement: Achievement) -> String {
        return """
        🏆 Achievement Unlocked! 🏆

        🏅 \(achievement.title)
        📝 \(achievement.description)
        ⭐ \(achievement.reward ?? "Keep it up!")

        Shared from Split Bill app
        """
    }
}

struct ShareButton: View {
    let shareText: String
    let icon: String
    let backgroundColor: Color

    init(
        shareText: String,
        icon: String = "square.and.arrow.up",
        backgroundColor: Color = DesignConstants.Colors.accent
    ) {
        self.shareText = shareText
        self.icon = icon
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        Button(action: {
            let activityViewController = UIActivityViewController(
                activityItems: [shareText],
                applicationActivities: nil
            )

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first,
               let rootViewController = window.rootViewController {
                rootViewController.present(activityViewController, animated: true)
            }
        }) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
        }
        .frame(width: 32, height: 32)
        .background(
            Circle()
                .fill(backgroundColor)
        )
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 20) {
        ShareButton(shareText: "Test share content")

        ShareButton(
            shareText: "Another test",
            icon: "square.and.arrow.up",
            backgroundColor: DesignConstants.Colors.secondary
        )
    }
    .padding()
    .background(DesignConstants.Colors.background)
}