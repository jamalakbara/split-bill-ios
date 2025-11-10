//
//  SearchHeader.swift
//  split bill
//
//  Created by Chairil Akbar on 11/11/25.
//

import SwiftUI

struct SearchHeader: View {
    @Binding var searchText: String
    let placeholder: String
    let onSearchChanged: (String) -> Void

    init(
        searchText: Binding<String>,
        placeholder: String = "Search...",
        onSearchChanged: @escaping (String) -> Void = { _ in }
    ) {
        self._searchText = searchText
        self.placeholder = placeholder
        self.onSearchChanged = onSearchChanged
    }

    var body: some View {
        HStack(spacing: 12) {
            // Search Bar
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(DesignConstants.Colors.textSecondary.opacity(0.6))

                TextField(placeholder, text: $searchText)
                    .font(DesignConstants.Typography.body)
                    .foregroundColor(DesignConstants.Colors.textPrimary)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .accessibilityLabel(placeholder)
                    .accessibilityHint("Type to search")
                    .onChange(of: searchText) { newValue in
                        onSearchChanged(newValue)
                    }

                // Clear Button
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                        onSearchChanged("")
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 16))
                            .foregroundColor(DesignConstants.Colors.textSecondary.opacity(0.5))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("Clear search")
                    .accessibilityHint("Clear current search text")
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(DesignConstants.Colors.textPrimary.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
            )
        }
        .padding(.horizontal, DesignConstants.horizontalPadding)
        .padding(.vertical, 8)
    }
}

#Preview {
    VStack(spacing: 20) {
        SearchHeader(
            searchText: .constant(""),
            placeholder: "Search bills...",
            onSearchChanged: { text in
                print("Searching for: \(text)")
            }
        )

        SearchHeader(
            searchText: .constant("Dinner"),
            placeholder: "Search friends..."
        )

        SearchHeader(
            searchText: .constant(""),
            placeholder: "Search groups..."
        )
    }
    .background(DesignConstants.Colors.background)
}