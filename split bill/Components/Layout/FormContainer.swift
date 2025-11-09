//
//  FormContainer.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct FormContainer<Content: View>: View {
    let title: String?
    let topPadding: CGFloat
    let fieldSpacing: CGFloat
    let buttonSpacing: CGFloat
    let showLogo: Bool
    let content: () -> Content

    init(
        title: String? = nil,
        topPadding: CGFloat = DesignConstants.verticalPadding,
        fieldSpacing: CGFloat = DesignConstants.formFieldSpacing,
        buttonSpacing: CGFloat = DesignConstants.formButtonSpacing,
        showLogo: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.topPadding = topPadding
        self.fieldSpacing = fieldSpacing
        self.buttonSpacing = buttonSpacing
        self.showLogo = showLogo
        self.content = content
    }

    var body: some View {
        ZStack {
            DesignConstants.Colors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // Logo
                    if showLogo {
                        SplitBillLogo(size: 120)
                            .padding(.bottom, 32)
                    }

                    // Title
                    if let title = title {
                        Text(title)
                            .font(DesignConstants.Typography.title1)
                            .fontWeight(.bold)
                            .foregroundColor(DesignConstants.Colors.textPrimary)
                            .padding(.bottom, 32)
                    }

                    // Form Content
                    VStack(spacing: fieldSpacing) {
                        content()
                    }
                    .padding(.bottom, buttonSpacing)

                    Spacer(minLength: 50)
                }
                .padding(.horizontal, DesignConstants.horizontalPadding)
                .padding(.top, topPadding)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // Login form with logo
        FormContainer(
            title: "Welcome Back",
            topPadding: DesignConstants.loginTopPadding,
            showLogo: true
        ) {
            // Email field
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "envelope")
                        .font(.system(size: 20))
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    TextField("Email", text: .constant(""))
                        .font(DesignConstants.Typography.body)
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    Spacer()
                }
                .padding(16)
            }
            .background(
                RoundedRectangle(cornerRadius: DesignConstants.CornerRadius.button)
                    .stroke(DesignConstants.Colors.textPrimary, lineWidth: DesignConstants.BorderWidth.thick)
                    .background(
                        RoundedRectangle(cornerRadius: DesignConstants.CornerRadius.button)
                            .fill(DesignConstants.Colors.white.opacity(0.3))
                    )
            )

            // Password field
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "lock")
                        .font(.system(size: 20))
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    SecureField("Password", text: .constant(""))
                        .font(DesignConstants.Typography.body)
                        .foregroundColor(DesignConstants.Colors.textPrimary)

                    Spacer()
                }
                .padding(16)
            }
            .background(
                RoundedRectangle(cornerRadius: DesignConstants.CornerRadius.button)
                    .stroke(DesignConstants.Colors.textPrimary, lineWidth: DesignConstants.BorderWidth.thick)
                    .background(
                        RoundedRectangle(cornerRadius: DesignConstants.CornerRadius.button)
                            .fill(DesignConstants.Colors.white.opacity(0.3))
                    )
            )

            // Login button
            PrimaryButton(
                text: "Log In",
                backgroundColor: DesignConstants.Colors.secondary,
                foregroundColor: DesignConstants.Colors.white,
                action: {}
            )

            // Sign up link
            TextButton(
                text: "Don't have an account? Sign up",
                action: {}
            )
        }
        .frame(height: 500)

        // Simple form without logo
        FormContainer(
            title: "Sign Up"
        ) {
            Text("Simple form content")
                .font(DesignConstants.Typography.body)
                .foregroundColor(DesignConstants.Colors.textSecondary)
        }
        .frame(height: 300)
    }
}