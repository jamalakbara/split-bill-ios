//
//  Achievements.swift
//  split bill
//
//  Created by Chairil Akbar on 10/11/25.
//

import SwiftUI

struct Achievement: Identifiable {
    let id: Int
    let title: String
    let description: String
    let iconName: String
    let progress: Int
    let total: Int
    let unlocked: Bool
    let color: String
    let reward: String?

    var progressPercentage: Double {
        guard total > 0 else { return 0 }
        return Double(progress) / Double(total)
    }

    var isComplete: Bool {
        progress >= total
    }
}

// Mock achievements data matching the React mockup
extension Achievement {
    static let mockAchievements: [Achievement] = [
        Achievement(
            id: 1,
            title: "First Split",
            description: "Split your first bill",
            iconName: "doc.text",
            progress: 1,
            total: 1,
            unlocked: true,
            color: "#fcbf49",
            reward: "50 points"
        ),
        Achievement(
            id: 2,
            title: "Social Butterfly",
            description: "Add 10 friends",
            iconName: "person.2",
            progress: 7,
            total: 10,
            unlocked: false,
            color: "#f77f00",
            reward: nil
        ),
        Achievement(
            id: 3,
            title: "Bill Master",
            description: "Split 50 bills",
            iconName: "trophy",
            progress: 23,
            total: 50,
            unlocked: false,
            color: "#fcbf49",
            reward: nil
        ),
        Achievement(
            id: 4,
            title: "Quick Draw",
            description: "Create a bill in under 30 seconds",
            iconName: "bolt",
            progress: 1,
            total: 1,
            unlocked: true,
            color: "#f77f00",
            reward: "100 points"
        ),
        Achievement(
            id: 5,
            title: "Generous Spirit",
            description: "Pay 25 bills",
            iconName: "heart",
            progress: 15,
            total: 25,
            unlocked: false,
            color: "#d62828",
            reward: nil
        ),
        Achievement(
            id: 6,
            title: "Party Planner",
            description: "Create 5 groups",
            iconName: "person.3",
            progress: 3,
            total: 5,
            unlocked: false,
            color: "#fcbf49",
            reward: nil
        ),
        Achievement(
            id: 7,
            title: "Big Spender",
            description: "Handle $1,000 in total bills",
            iconName: "trending.up",
            progress: 650,
            total: 1000,
            unlocked: false,
            color: "#f77f00",
            reward: nil
        ),
        Achievement(
            id: 8,
            title: "Streak Master",
            description: "Split bills 7 days in a row",
            iconName: "star",
            progress: 4,
            total: 7,
            unlocked: false,
            color: "#fcbf49",
            reward: nil
        ),
        Achievement(
            id: 9,
            title: "Perfect Balance",
            description: "Settle all debts",
            iconName: "medal",
            progress: 1,
            total: 1,
            unlocked: true,
            color: "#fcbf49",
            reward: "200 points"
        ),
        Achievement(
            id: 10,
            title: "Legend",
            description: "Split 100 bills",
            iconName: "crown",
            progress: 23,
            total: 100,
            unlocked: false,
            color: "#d62828",
            reward: nil
        )
    ]
}

// Achievement statistics helper
extension Array where Element == Achievement {
    var unlockedCount: Int {
        filter { $0.unlocked }.count
    }

    var totalPoints: Int {
        filter { $0.unlocked && $0.reward != nil }
            .compactMap { achievement -> Int? in
                guard let reward = achievement.reward else { return nil }
                let points = reward.replacingOccurrences(of: " points", with: "")
                return Int(points)
            }
            .reduce(0, +)
    }
}