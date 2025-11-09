//
//  SplitBillLogo.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct SplitBillLogo: View {
    let size: CGFloat

    init(size: CGFloat = 96) {
        self.size = size
    }

    var body: some View {
        ZStack {
            // Main container
            RoundedRectangle(cornerRadius: size * 0.5)
                .frame(width: size, height: size)
                .foregroundColor(Color(hex: "#003049"))
                .shadow(color: .black.opacity(0.1), radius: size * 0.104, x: 0, y: size * 0.104)

            // Logo elements - three circles
            ZStack {
                // Yellow circle
                Circle()
                    .frame(width: size * 0.5, height: size * 0.5)
                    .foregroundColor(Color(hex: "#fcbf49"))

                // Orange circle (overlapping)
                Circle()
                    .frame(width: size * 0.333, height: size * 0.333)
                    .foregroundColor(Color(hex: "#f77f00"))
                    .offset(x: size * 0.25, y: size * 0.25)

                // Red circle (overlapping)
                Circle()
                    .frame(width: size * 0.25, height: size * 0.25)
                    .foregroundColor(Color(hex: "#d62828"))
                    .offset(x: -size * 0.083, y: 0)
            }
            .offset(x: size * 0.25, y: size * 0.25)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        SplitBillLogo(size: 96)
        SplitBillLogo(size: 48)
        SplitBillLogo()
    }
}