//
//  ContentView.swift
//  split bill
//
//  Created by Chairil Akbar on 09/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showSignUp = false
    @State private var showOnboarding = false
    @State private var showMainScreen = false
    @State private var showViewBill = false
    @State private var selectedBill: RecentBill?

    var body: some View {
        if showViewBill, let bill = selectedBill {
            ViewBillView(bill: bill)
        } else if showMainScreen {
            MainScreenView(showViewBill: $showViewBill, selectedBill: $selectedBill)
        } else if showOnboarding {
            OnboardingView(showMainScreen: $showMainScreen)
        } else if showSignUp {
            SignUpView(
                showLogin: $showSignUp,
                showOnboarding: $showOnboarding,
                showMainScreen: $showMainScreen
            )
        } else {
            LoginView(showSignUp: $showSignUp, showMainScreen: $showMainScreen)
        }
    }
}

#Preview {
    ContentView()
}