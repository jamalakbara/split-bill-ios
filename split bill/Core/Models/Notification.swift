//
//  Notification.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct AppNotification: Identifiable {
    let id: Int
    let type: NotificationType
    let title: String
    let message: String
    let time: String
    let iconName: String
    let color: Color
    let isRead: Bool
}

enum NotificationType {
    case payment
    case reminder
    case group

    var defaultIcon: String {
        switch self {
        case .payment:
            return "dollarsign.circle"
        case .reminder:
            return "doc.text"
        case .group:
            return "person.3"
        }
    }

    var defaultColor: Color {
        switch self {
        case .payment:
            return DesignConstants.Colors.accent
        case .reminder:
            return DesignConstants.Colors.danger
        case .group:
            return DesignConstants.Colors.secondary
        }
    }
}