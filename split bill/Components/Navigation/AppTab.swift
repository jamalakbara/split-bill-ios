//
//  AppTab.swift
//  split bill
//
//  Created by Chairil Akbar on 11/11/25.
//

import SwiftUI

enum AppTab: CaseIterable, Identifiable {
    case home
    case groups
    case people
    case settings

    var id: String {
        switch self {
        case .home: return "home"
        case .groups: return "groups"
        case .people: return "people"
        case .settings: return "settings"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .groups: return "person.2"
        case .people: return "person.3"
        case .settings: return "gearshape"
        }
    }

    var title: String {
        switch self {
        case .home: return "Home"
        case .groups: return "Groups"
        case .people: return "People"
        case .settings: return "Settings"
        }
    }
}