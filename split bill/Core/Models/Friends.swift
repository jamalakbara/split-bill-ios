//
//  Friends.swift
//  split bill
//
//  Created by Chairil Akbar on 10/11/25.
//

import SwiftUI

// MARK: - Friend Data Model
struct Friend: Identifiable, Equatable {
    let id: Int
    let name: String
    let image: String
    var isSelected: Bool = false

    static let allFriends: [Friend] = [
        Friend(id: 1, name: "Cooper", image: "https://images.unsplash.com/photo-1683342599486-761e6afce7e4?w=100&h=100&fit=crop"),
        Friend(id: 2, name: "Warren", image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop"),
        Friend(id: 3, name: "Jessy", image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop"),
        Friend(id: 4, name: "Jacob", image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&h=100&fit=crop"),
        Friend(id: 5, name: "Sarah", image: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop"),
        Friend(id: 6, name: "Michael", image: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop"),
        Friend(id: 7, name: "Emma", image: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&h=100&fit=crop"),
        Friend(id: 8, name: "David", image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100&h=100&fit=crop")
    ]

    static let suggestedPeople: [Friend] = [
        Friend(id: 9, name: "Alex", image: "https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=100&h=100&fit=crop"),
        Friend(id: 10, name: "Sophia", image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop"),
        Friend(id: 11, name: "James", image: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100&h=100&fit=crop"),
        Friend(id: 12, name: "Olivia", image: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=100&h=100&fit=crop"),
        Friend(id: 13, name: "Ryan", image: "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=100&h=100&fit=crop"),
        Friend(id: 14, name: "Lily", image: "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=100&h=100&fit=crop")
    ]
}