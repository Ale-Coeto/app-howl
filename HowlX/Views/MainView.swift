//
//  MainView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            
            CallView()
                .tabItem {
                    Label("Análisis", systemImage: "microphone.fill")
                }
            
            
            LogsView()
                .tabItem {
                    Label("Pendientes", systemImage: "list.bullet")
                }
            
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
