//
//  OnboardingView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentSlide = 0
    @Binding var showMainScreen: Bool

    init(showMainScreen: Binding<Bool> = .constant(false)) {
        self._showMainScreen = showMainScreen
    }

    let slides = [
        OnboardingSlide(
            icon: "doc.text.fill",
            title: "Split Bills Easily",
            description: "Upload receipts and split expenses with friends in seconds!",
            color: "#f77f00"
        ),
        OnboardingSlide(
            icon: "person.2.fill",
            title: "Create Groups",
            description: "Organize your friends into groups for trips, roommates, or events",
            color: "#fcbf49"
        ),
        OnboardingSlide(
            icon: "sparkles",
            title: "Track Balances",
            description: "See who owes what at a glance. Never forget who paid!",
            color: "#d62828"
        )
    ]

    var body: some View {
        ScreenContainer(
            backgroundColor: DesignConstants.Colors.background,
            hasScrollView: false
        ) {
            VStack(spacing: 0) {
                Spacer()

                // Icon
                ZStack {
                    Circle()
                        .frame(width: 128, height: 128)
                        .foregroundColor(Color(hex: slides[currentSlide].color))
                        .shadow(color: DesignConstants.Colors.textPrimary, radius: 0, x: 6, y: 6)

                    Image(systemName: slides[currentSlide].icon)
                        .font(.system(size: 64))
                        .foregroundColor(.white)
                }
                .overlay(
                    Circle()
                        .stroke(DesignConstants.Colors.textPrimary, lineWidth: DesignConstants.BorderWidth.card)
                )
                .padding(.bottom, DesignConstants.sectionSpacing)

                // Title
                Text(slides[currentSlide].title)
                    .font(DesignConstants.Typography.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(DesignConstants.Colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)

                // Description
                Text(slides[currentSlide].description)
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()

                // Dots indicator
                HStack(spacing: 8) {
                    ForEach(0..<slides.count, id: \.self) { index in
                        Rectangle()
                            .frame(height: 12)
                            .frame(width: index == currentSlide ? 32 : 12)
                            .foregroundColor(index == currentSlide ? DesignConstants.Colors.textPrimary : DesignConstants.Colors.textPrimary.opacity(0.3))
                            .cornerRadius(6)
                            .animation(.easeInOut(duration: 0.3), value: currentSlide)
                    }
                }
                .padding(.bottom, DesignConstants.sectionSpacing)

                // Navigation buttons
                VStack(spacing: DesignConstants.contentSpacing) {
                    // Next/Get Started button
                    PrimaryButton(
                        text: currentSlide == slides.count - 1 ? "Get Started" : "Next",
                        icon: currentSlide < slides.count - 1 ? "chevron.right" : nil,
                        backgroundColor: DesignConstants.Colors.secondary,
                        foregroundColor: DesignConstants.Colors.white,
                        action: {
                            if currentSlide < slides.count - 1 {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    currentSlide += 1
                                }
                            } else {
                                showMainScreen = true
                            }
                        }
                    )
                    .scaleEffect(currentSlide < slides.count - 1 ? 1.0 : 1.0)
                    .animation(.easeInOut(duration: 0.1), value: currentSlide)

                    // Skip button
                    TextButton(
                        text: "Skip",
                        action: {
                            showMainScreen = true
                        }
                    )
                    .padding(.bottom, DesignConstants.sectionSpacing)
                }
        }
    }
}

#Preview {
    OnboardingView()
}