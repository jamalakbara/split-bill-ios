//
//  BillPerson.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import Foundation

struct BillPerson {
    let id: Int
    let name: String
    let image: String
    let total: Double
    let items: [BillItem]
}