//
//  SignUpView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct SignUpView: View {
    @Binding var showLogin: Bool
    @Binding var showOnboarding: Bool
    @Binding var showMainScreen: Bool
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        ScreenContainer(
            backgroundColor: DesignConstants.Colors.background,
            hasScrollView: false
        ) {
            VStack(spacing: 0) {
                Spacer()

                // Logo
                SplitBillLogo(size: 96)

                // App name
                Text("SplitBill")
                    .font(DesignConstants.Typography.title1)
                    .fontWeight(.black)
                    .foregroundColor(DesignConstants.Colors.textPrimary)
                    .padding(.top, 27.28)

                // Tagline
                Text("Join the split bill family!")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
                    .padding(.top, 16.4)

                Spacer()

                // Form area
                VStack(spacing: DesignConstants.formFieldSpacing) {
                // Full Name input
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "person")
                            .font(.system(size: 20))
                            .foregroundColor(DesignConstants.Colors.textPrimary)

                        TextField("Full Name", text: $fullName)
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

                // Email input
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "envelope")
                            .font(.system(size: 20))
                            .foregroundColor(DesignConstants.Colors.textPrimary)

                        TextField("Email", text: $email)
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

                // Password input
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "lock")
                            .font(.system(size: 20))
                            .foregroundColor(DesignConstants.Colors.textPrimary)

                        SecureField("Password", text: $password)
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

                // Confirm Password input
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "lock")
                            .font(.system(size: 20))
                            .foregroundColor(DesignConstants.Colors.textPrimary)

                        SecureField("Confirm Password", text: $confirmPassword)
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

                // Sign Up button
                PrimaryButton(
                    text: "Sign Up",
                    backgroundColor: DesignConstants.Colors.secondary,
                    foregroundColor: DesignConstants.Colors.white,
                    fontSize: 14,
                    action: {
                        showOnboarding = true
                    }
                )

                // Log in link
                TextButton(
                    text: "Already have an account? Log in",
                    action: {
                        showLogin = false
                    }
                )
                }
                .padding(.bottom, DesignConstants.formButtonSpacing)
            }
        }
    }
}

#Preview {
    SignUpView(
        showLogin: .constant(false),
        showOnboarding: .constant(false),
        showMainScreen: .constant(false)
    )
}