//
//  AccountListView.swift
//  split bill
//
//  Created by Chairil Akbar on 14/11/25.
//

import SwiftUI

enum CardType {
    case visa
    case mastercard
    case amex
}

struct PaymentCard {
    let id: String
    let bankName: String
    let lastFour: String
    let cardHolder: String
    let type: CardType
    let color: String

    static let mockCards: [PaymentCard] = [
        PaymentCard(
            id: "1",
            bankName: "CHASE",
            lastFour: "8160",
            cardHolder: "Jacob Jones",
            type: .mastercard,
            color: "#003049"
        ),
        PaymentCard(
            id: "2",
            bankName: "CHASE",
            lastFour: "4729",
            cardHolder: "Jane Coo",
            type: .visa,
            color: "#d62828"
        )
    ]
}

struct AccountListView: View {
    @Binding var showAccountList: Bool
    @Binding var showSettings: Bool
    @Binding var showAddCard: Bool

    @State private var selectedCardId: String = PaymentCard.mockCards[0].id

    var body: some View {
        ScreenContainer(
            title: "Accounts",
            backgroundColor: Color(hex: "#eae2b7"),
            showBackButton: true,
            showEditButton: true,
            backButtonAction: {
                showAccountList = false
            },
            editButtonAction: {
                showAddCard = true
            },
            editButtonIcon: "plus",
            hasScrollView: true
        ) {
            LazyVStack(spacing: 16) {
                // Payment Cards List
                paymentCardsList

                // Bottom padding
                Color.clear
                    .frame(height: 32)
            }
        }
    }

    
    // MARK: - Payment Cards List
    private var paymentCardsList: some View {
        VStack(spacing: 16) {
            ForEach(PaymentCard.mockCards, id: \.id) { card in
                paymentCardButton(card)
            }
        }
    }

    // MARK: - Individual Payment Card Button
    private func paymentCardButton(_ card: PaymentCard) -> some View {
        Button(action: {
            selectedCardId = card.id
        }) {
            ZStack {
                // Card background
                VStack(spacing: 16) {
                    // Top section with bank name and card type
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(card.bankName)
                                .font(.system(size: 18, weight: .heavy))
                                .foregroundColor(Color(hex: "#003049"))

                            HStack(spacing: 8) {
                                Image(systemName: "creditcard")
                                    .font(.system(size: 32, weight: .medium))
                                    .foregroundColor(Color(hex: "#003049"))

                                Text("••••")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(hex: "#003049"))
                            }
                        }

                        Spacer()

                        // Card type logo
                        cardTypeLogo(for: card.type)
                    }

                    // Card number
                    HStack {
                        Text("•••• \(card.lastFour)")
                            .font(.system(size: 20, weight: .heavy))
                            .foregroundColor(Color(hex: "#003049"))

                        Spacer()
                    }

                    // Card holder
                    HStack {
                        Text(card.cardHolder)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(hex: "#003049").opacity(0.7))

                        Spacer()
                    }
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(24)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            selectedCardId == card.id ? Color(hex: "#f77f00") : Color(hex: "#003049"),
                            lineWidth: 4
                        )
                )
                .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
                .scaleEffect(selectedCardId == card.id ? 1.02 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: selectedCardId)

                // Selected indicator
                if selectedCardId == card.id {
                    VStack {
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(Color(hex: "#f77f00"))
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 4)
                                    )

                                Image(systemName: "checkmark")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .offset(y: -8)
                        }
                        Spacer()
                    }
                    .offset(x: 8, y: -8)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - Card Type Logo
    @ViewBuilder
    private func cardTypeLogo(for type: CardType) -> some View {
        switch type {
        case .mastercard:
            HStack(spacing: -8) {
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(hex: "#d62828"))
                    .opacity(0.8)

                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(hex: "#f77f00"))
                    .opacity(0.8)
            }
        case .visa:
            Text("VISA")
                .font(.system(size: 16, weight: .black))
                .foregroundColor(Color(hex: "#003049"))
                .tracking(2)
        case .amex:
            Text("AMEX")
                .font(.system(size: 16, weight: .black))
                .foregroundColor(Color(hex: "#003049"))
                .tracking(1)
        }
    }

    
    }

#Preview {
    AccountListView(
        showAccountList: .constant(true),
        showSettings: .constant(false),
        showAddCard: .constant(false)
    )
}