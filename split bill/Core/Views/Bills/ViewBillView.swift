//
//  ViewBillView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct ViewBillView: View {
    let bill: RecentBill
    @State private var expandedPerson: Int? = nil
    @Environment(\.dismiss) private var dismiss

    // Sample data for demonstration - in real app this would come from the bill
    let people = [
        BillPerson(
            id: 1,
            name: "Cooper",
            image: "https://images.unsplash.com/photo-1683342599486-761e6afce7e4?w=100&h=100&fit=crop",
            total: 22.0,
            items: [
                BillItem(name: "8\" Pizza", quantity: 2, unitPrice: 22.0, totalPrice: 44.0, image: "https://images.unsplash.com/photo-1681567604770-0dc826c870ae?w=100&h=100&fit=crop"),
                BillItem(name: "8\" Pizza", quantity: 2, unitPrice: 22.0, totalPrice: 44.0, image: "https://images.unsplash.com/photo-1681567604770-0dc826c870ae?w=100&h=100&fit=crop")
            ]
        ),
        BillPerson(
            id: 2,
            name: "Jessy",
            image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop",
            total: 22.0,
            items: [
                BillItem(name: "8\" Pizza", quantity: 2, unitPrice: 22.0, totalPrice: 44.0, image: "https://images.unsplash.com/photo-1681567604770-0dc826c870ae?w=100&h=100&fit=crop"),
                BillItem(name: "8\" Pizza", quantity: 2, unitPrice: 22.0, totalPrice: 44.0, image: "https://images.unsplash.com/photo-1681567604770-0dc826c870ae?w=100&h=100&fit=crop")
            ]
        )
    ]

    var body: some View {
        ScreenContainer(
            title: "Bill Detail",
            showBackButton: true,
            showEditButton: true,
            backButtonAction: {
                dismiss()
            },
            editButtonAction: {
                // Edit bill action
            },
            hasScrollView: true
        ) {
            VStack(spacing: DesignConstants.contentSpacing) {
                // Total Bill Amount
                StandardCard {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total bill")
                        .font(DesignConstants.Typography.callout)
                        .foregroundColor(DesignConstants.Colors.textSecondary)

                    Text("$243")
                        .font(DesignConstants.Typography.largeTitle)
                        .foregroundColor(DesignConstants.Colors.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

                // People Bills
                ForEach(people, id: \.id) { person in
                    StandardCard(cornerRadius: DesignConstants.CornerRadius.large) {
                        VStack(spacing: 0) {
                                // Person Header Section
                                VStack(spacing: 0) {
                                    Button(action: {
                                        // Navigate to profile
                                    }) {
                                        HStack(spacing: 12) {
                                        // Person Image
                                        AsyncImage(url: URL(string: person.image)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Circle()
                                                .frame(width: 48, height: 48)
                                                .foregroundColor(DesignConstants.Colors.textPrimary.opacity(0.3))
                                        }
                                        .frame(width: 48, height: 48)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(DesignConstants.Colors.textPrimary, lineWidth: DesignConstants.BorderWidth.medium)
                                        )

                                        // Person Info
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text("\(person.name)'s total bill")
                                                .font(DesignConstants.Typography.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(DesignConstants.Colors.textPrimary)

                                            Text(String(format: "$%.2f", person.total))
                                                .font(DesignConstants.Typography.callout)
                                                .foregroundColor(DesignConstants.Colors.textSecondary)
                                        }

                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(DesignConstants.cardPadding)
                                }

                                // Divider
                                Divider()
                                    .background(DesignConstants.Colors.textPrimary.opacity(0.1))
                                    .padding(EdgeInsets(top: 0, leading: DesignConstants.cardPadding, bottom: 0, trailing: DesignConstants.cardPadding))
                            }

                                // Items List
                                VStack(spacing: 12) {
                                    // Add some spacing after divider
                                    Color.clear
                                        .frame(height: 8)

                                    VStack(spacing: 12) {
                                    ForEach(person.items.indices, id: \.self) { index in
                                        let item = person.items[index]
                                        HStack(spacing: 12) {
                                            // Item Image
                                            AsyncImage(url: URL(string: item.image)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                Circle()
                                                    .frame(width: 48, height: 48)
                                                    .foregroundColor(DesignConstants.Colors.textPrimary.opacity(0.2))
                                            }
                                            .frame(width: 48, height: 48)
                                            .clipShape(Circle())
                                            .overlay(
                                                Circle()
                                                    .stroke(DesignConstants.Colors.textPrimary, lineWidth: DesignConstants.BorderWidth.thin)
                                                    .opacity(0.2)
                                            )

                                            // Item Info
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(item.name)
                                                    .font(DesignConstants.Typography.body)
                                                    .foregroundColor(DesignConstants.Colors.textPrimary)

                                                Text(String(format: "$%.2f", item.unitPrice))
                                                    .font(DesignConstants.Typography.caption)
                                                    .foregroundColor(DesignConstants.Colors.textSecondary)
                                            }

                                            Spacer()

                                            // Quantity
                                            Text("\(item.quantity)x")
                                                .font(DesignConstants.Typography.callout)
                                                .foregroundColor(DesignConstants.Colors.textSecondary)

                                            // Total Price
                                            Text(String(format: "$%.1f", item.totalPrice))
                                                .font(DesignConstants.Typography.callout)
                                                .foregroundColor(DesignConstants.Colors.textPrimary)
                                                .frame(width: 64, alignment: .trailing)
                                        }
                                    }

                                    // See Details Button
                                    SecondaryButton(
                                        text: "See details",
                                        showChevron: true,
                                        isExpanded: expandedPerson == person.id,
                                        action: {
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                expandedPerson = expandedPerson == person.id ? nil : person.id
                                            }
                                        }
                                    )

                                    // Expanded Details
                                    if expandedPerson == person.id {
                                        SecondaryCard {
                                            VStack(spacing: 8) {
                                                Text("Breakdown")
                                                    .font(DesignConstants.Typography.callout)
                                                    .foregroundColor(DesignConstants.Colors.textPrimary.opacity(0.8))

                                                VStack(spacing: 4) {
                                                    HStack {
                                                        Text("Subtotal")
                                                            .font(DesignConstants.Typography.callout)
                                                            .foregroundColor(DesignConstants.Colors.textSecondary)

                                                        Spacer()

                                                        Text("$88.00")
                                                            .font(DesignConstants.Typography.callout)
                                                            .foregroundColor(DesignConstants.Colors.textPrimary)
                                                    }

                                                    HStack {
                                                        Text("Tax (10%)")
                                                            .font(DesignConstants.Typography.callout)
                                                            .foregroundColor(DesignConstants.Colors.textSecondary)

                                                        Spacer()

                                                        Text("$8.80")
                                                            .font(DesignConstants.Typography.callout)
                                                            .foregroundColor(DesignConstants.Colors.textPrimary)
                                                    }

                                                    HStack {
                                                        Text("Service charge")
                                                            .font(DesignConstants.Typography.callout)
                                                            .foregroundColor(DesignConstants.Colors.textSecondary)

                                                        Spacer()

                                                        Text("$5.20")
                                                            .font(DesignConstants.Typography.callout)
                                                            .foregroundColor(DesignConstants.Colors.textPrimary)
                                                    }

                                                    Divider()
                                                        .background(DesignConstants.Colors.textPrimary.opacity(0.2))

                                                    HStack {
                                                        Text("Total")
                                                            .font(DesignConstants.Typography.callout)
                                                            .foregroundColor(DesignConstants.Colors.textPrimary)
                                                            .fontWeight(.bold)

                                                        Spacer()

                                                        Text(String(format: "$%.2f", person.total))
                                                            .font(DesignConstants.Typography.callout)
                                                            .foregroundColor(DesignConstants.Colors.textPrimary)
                                                            .fontWeight(.bold)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: DesignConstants.contentSpacing / 4, trailing: 0))
                            }
                        }
                    }

                    // Tax Section
                    StandardCard {
                        HStack {
                            Text("TAX")
                                .font(DesignConstants.Typography.body)
                                .fontWeight(.bold)
                                .foregroundColor(DesignConstants.Colors.textPrimary)

                            Spacer()

                            Text("$17.60")
                                .font(DesignConstants.Typography.body)
                                .foregroundColor(DesignConstants.Colors.textPrimary)
                        }
                    }
                }

                // Share Button
                PrimaryButton(
                    text: "SHARE",
                    icon: "square.and.arrow.up",
                    cornerRadius: 28,
                    shadowOffset: 4,
                    action: {
                        dismiss()
                    }
                )
                .padding(EdgeInsets(top: DesignConstants.formButtonSpacing, leading: 0, bottom: DesignConstants.contentSpacing / 3, trailing: 0))
            }
        }
    }
}



#Preview {
    ViewBillView(bill: RecentBill(
        id: 1,
        title: "Dinner at Pizza Place",
        date: "Nov 5, 2025",
        amount: 45.50,
        type: "owe",
        friend: "Sarah"
    ))
}
