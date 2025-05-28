//
//  MainView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var authManager: AuthManager
    
    var body: some View {
        TabView {
            
            CallView()
                .tabItem {
                    Label("Análisis", systemImage: "microphone.fill")
                }
            
//            LogsView()
//                .tabItem {
//                    Label("Pendientes", systemImage: "list.bullet")
//                }
//            
            ProfileView(authManager: authManager)
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    MainView(authManager: AuthManager())
}
