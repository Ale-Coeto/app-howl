//
//  ContentView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct LandingView: View {
    @StateObject private var authManager = AuthManager()

    var body: some View {
        Group {
            if authManager.isLoggedIn {
                MainView(authManager: authManager)
            } else {
                AuthView(authManager: authManager)
            }
        }
        
    }
}

#Preview {
    LandingView()
}
