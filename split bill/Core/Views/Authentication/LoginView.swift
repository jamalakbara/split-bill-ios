//
//  LoginView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var showSignUp: Bool
    @Binding var showMainScreen: Bool

    init(showSignUp: Binding<Bool> = .constant(false), showMainScreen: Binding<Bool> = .constant(false)) {
        self._showSignUp = showSignUp
        self._showMainScreen = showMainScreen
    }

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
                Text("Split bills with friends easily!")
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textSecondary)
                    .padding(.top, 16.4)

                Spacer()

                // Form area
                VStack(spacing: DesignConstants.formFieldSpacing) {
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

                // Login button
                PrimaryButton(
                    text: "Log In",
                    backgroundColor: DesignConstants.Colors.secondary,
                    foregroundColor: DesignConstants.Colors.white,
                    fontSize: 14,
                    action: {
                        showMainScreen = true
                    }
                )

                // Sign up link
                TextButton(
                    text: "Don't have an account? Sign up",
                    action: {
                        showSignUp = true
                    }
                )
                }
                .padding(.bottom, DesignConstants.formButtonSpacing)
            }
        }
    }
}

#Preview {
    LoginView()
}