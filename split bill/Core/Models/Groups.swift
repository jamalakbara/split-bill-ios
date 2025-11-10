import SwiftUI
import Foundation

// MARK: - Group Data Model
struct GroupModel: Identifiable {
    let id: Int
    let name: String
    let members: Int
    let balance: Double
    let color: String
    let emoji: String

    init(id: Int, name: String, members: Int, balance: Double, color: String, emoji: String) {
        self.id = id
        self.name = name
        self.members = members
        self.balance = balance
        self.color = color
        self.emoji = emoji
    }
}

// MARK: - Group Member Data Model
struct GroupMember: Identifiable {
    let id: Int
    let name: String
    let avatar: String
    let owed: Double
    let owes: Bool

    init(id: Int, name: String, avatar: String, owed: Double, owes: Bool) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.owed = owed
        self.owes = owes
    }
}

// MARK: - Group Bill Data Model
struct GroupBill: Identifiable {
    let id: Int
    let title: String
    let amount: Double
    let date: String
    let color: String

    init(id: Int, title: String, amount: Double, date: String, color: String) {
        self.id = id
        self.title = title
        self.amount = amount
        self.date = date
        self.color = color
    }
}

// MARK: - Mock Data
let mockGroups: [GroupModel] = [
    GroupModel(id: 1, name: "Roommates", members: 4, balance: -125.50, color: "#f77f00", emoji: "🐻"),
    GroupModel(id: 2, name: "Trip to Vegas", members: 6, balance: 89.25, color: "#fcbf49", emoji: "🦊"),
    GroupModel(id: 3, name: "Friday Night Crew", members: 5, balance: 0, color: "#d62828", emoji: "🐱")
]

let mockGroupMembers: [GroupMember] = [
    GroupMember(id: 1, name: "Sarah Chen", avatar: "S", owed: 22.50, owes: false),
    GroupMember(id: 2, name: "Mike Johnson", avatar: "M", owed: 0, owes: false),
    GroupMember(id: 3, name: "Emma Wilson", avatar: "E", owed: 15.75, owes: true),
    GroupMember(id: 4, name: "You", avatar: "Y", owed: 30.00, owes: false)
]

let mockGroupBills: [GroupBill] = [
    GroupBill(id: 1, title: "Grocery Shopping", amount: 124.80, date: "Nov 7, 2025", color: "#f77f00"),
    GroupBill(id: 2, title: "Electric Bill", amount: 89.50, date: "Nov 5, 2025", color: "#fcbf49"),
    GroupBill(id: 3, title: "Internet Service", amount: 65.00, date: "Nov 1, 2025", color: "#d62828")
]