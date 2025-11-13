//
//  AddAccountView.swift
//  split bill
//
//  Created by Chairil Akbar on 14/11/25.
//

import SwiftUI

struct AddAccountView: View {
    @Binding var showAddCard: Bool
    @Binding var showAccountList: Bool

    @State private var bankName: String = ""
    @State private var cardNumber: String = ""
    @State private var cardHolder: String = ""
    @State private var expiryDate: String = ""
    @State private var cvv: String = ""

    var body: some View {
        ScreenContainer(
            title: "Add Account",
            backgroundColor: Color(hex: "#eae2b7"),
            showBackButton: true,
            showEditButton: false,
            backButtonAction: {
                showAddCard = false
                showAccountList = true
            },
            hasScrollView: true
        ) {
            VStack(spacing: 24) {
                // Card Preview
                cardPreview

                // Form Fields
                VStack(spacing: 16) {
                    // Bank Name
                    formField(
                        title: "Bank Name",
                        placeholder: "BANK NAME",
                        text: $bankName,
                        icon: "creditcard",
                        onTextChanged: { newValue in
                            bankName = newValue.uppercased()
                        }
                    )

                    // Card Number
                    formField(
                        title: "Account Number",
                        placeholder: "1234 5678 9012 3456",
                        text: $cardNumber,
                        icon: "creditcard",
                        keyboardType: .numberPad,
                        onTextChanged: { newValue in
                            cardNumber = formatCardNumber(newValue)
                        }
                    )

                    // Card Holder Name
                    formField(
                        title: "Cardholder Name",
                        placeholder: "JOHN DOE",
                        text: $cardHolder,
                        icon: "person",
                        onTextChanged: { newValue in
                            cardHolder = newValue.uppercased()
                        }
                    )
                }

                // Save Account Button
                saveAccountButton

                // Bottom padding
                Color.clear
                    .frame(height: 32)
            }
        }
    }

    // MARK: - Card Preview
    private var cardPreview: some View {
        VStack(spacing: 0) {
            HStack {
                // Chip area
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 48, height: 40)
                        .foregroundColor(Color(hex: "#fcbf49"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.4), lineWidth: 2)
                        )

                    Text(bankName.isEmpty ? "CHIP" : String(bankName.prefix(4)))
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(Color(hex: "#003049"))
                }

                Spacer()

                // Credit card icon
                Image(systemName: "creditcard")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(.white.opacity(0.6))
            }
            .padding(.bottom, 24)

            VStack(spacing: 12) {
                // Card number
                Text(cardNumber.isEmpty ? "•••• •••• •••• ••••" : cardNumber)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .tracking(2)

                // Card holder section
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Card Holder")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.6))

                        Text(cardHolder.isEmpty ? "YOUR NAME" : cardHolder)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }

                    Spacer()
                }
            }
        }
        .padding(24)
        .frame(minHeight: 200)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "#003049"),
                    Color(hex: "#004d6d")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(hex: "#003049"), lineWidth: 4)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
    }

    // MARK: - Form Field
    private func formField(
        title: String,
        placeholder: String,
        text: Binding<String>,
        icon: String,
        keyboardType: UIKeyboardType = .default,
        onTextChanged: @escaping (String) -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "#003049"))

            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color(hex: "#fcbf49"))
                        .overlay(
                            Circle()
                                .stroke(Color(hex: "#003049"), lineWidth: 2)
                        )

                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(hex: "#003049"))
                }

                TextField(placeholder, text: text)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#003049"))
                    .textContentType(.none)
                    .keyboardType(keyboardType)
                    .autocapitalization(.allCharacters)
                    .onChange(of: text.wrappedValue) { _, newValue in
                        onTextChanged(newValue)
                    }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(hex: "#003049"), lineWidth: 4)
            )
            .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
        }
    }

    // MARK: - Save Account Button
    private var saveAccountButton: some View {
        PrimaryButton(
            text: "Save Account",
            backgroundColor: Color(hex: "#f77f00"),
            foregroundColor: .white,
            borderColor: Color(hex: "#003049"),
            cornerRadius: 16,
            height: 56,
            fontSize: 18,
            fontWeight: .heavy,
            shadowOffset: 4,
            action: {
                // Handle card addition logic here
                showAddCard = false
                showAccountList = true
            }
        )
    }

    
    // MARK: - Helper Functions
    private func formatCardNumber(_ input: String) -> String {
        let cleaned = input.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let result = cleaned.enumerated().map { (index, element) in
            if index > 0 && index % 4 == 0 {
                return " \(element)"
            } else {
                return String(element)
            }
        }.joined()

        return String(result.prefix(19)) // Max 16 digits + 3 spaces
    }
}

#Preview {
    AddAccountView(
        showAddCard: .constant(true),
        showAccountList: .constant(false)
    )
}