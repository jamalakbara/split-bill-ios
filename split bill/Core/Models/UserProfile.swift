//
//  UserProfile.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct UserProfile {
    let id: Int
    let name: String
    let image: String
}

struct DebtInfo {
    let amount: Double
    let youOwe: Bool

    var isSettled: Bool {
        return amount == 0
    }
}

struct SharedBill {
    let id: Int
    let title: String
    let date: String
    let amount: Double
    let iconColor: Color
}

struct ProfileStats {
    let totalSpent: String
    let billsSplit: Int
    let mutualContacts: Int
}

struct ProfileAction {
    let id: Int
    let title: String
    let subtitle: String
    let icon: String
    let iconColor: Color
    let action: () -> Void
}