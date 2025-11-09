//
//  ContentContainer.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct ContentContainer<Content: View>: View {
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    let backgroundColor: Color
    let hasScrollView: Bool
    let content: () -> Content

    init(
        horizontalPadding: CGFloat = DesignConstants.horizontalPadding,
        verticalPadding: CGFloat = DesignConstants.verticalPadding,
        backgroundColor: Color = DesignConstants.Colors.background,
        hasScrollView: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.backgroundColor = backgroundColor
        self.hasScrollView = hasScrollView
        self.content = content
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            if hasScrollView {
                ScrollView {
                    content()
                        .padding(.horizontal, horizontalPadding)
                        .padding(.vertical, verticalPadding)
                }
            } else {
                content()
                    .padding(.horizontal, horizontalPadding)
                    .padding(.vertical, verticalPadding)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // With ScrollView
        ContentContainer(hasScrollView: true) {
            VStack(spacing: 16) {
                Text("Scrollable Content")
                    .font(DesignConstants.Typography.title1)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                ForEach(0..<10, id: \.self) { index in
                    HStack {
                        Text("Item \(index + 1)")
                            .font(DesignConstants.Typography.body)
                        Spacer()
                    }
                    .padding()
                    .background(DesignConstants.Colors.white)
                    .cornerRadius(DesignConstants.CornerRadius.card)
                }
            }
        }
        .frame(height: 300)

        // Without ScrollView
        ContentContainer {
            VStack(spacing: 16) {
                Text("Static Content")
                    .font(DesignConstants.Typography.title1)
                    .foregroundColor(DesignConstants.Colors.textPrimary)

                Text("This content doesn't scroll and has consistent padding.")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
            }
        }
        .frame(height: 200)
    }
}