//
//  RecentBill.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import Foundation

struct RecentBill {
    let id: Int
    let title: String
    let date: String
    let amount: Double
    let type: String // "owe" or "owes"
    let friend: String
}