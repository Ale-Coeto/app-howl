//
//  ProfileView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var authManager: AuthManager
    @ObservedObject  var vm = ProfileVM()
    
    var body: some View {
        VStack {
            LargeTitle(text: "Profile", highlightedText: "Page")
                .padding(.bottom, 50)
            
            CircleIconView(icon: "person.fill")
            
            Text(vm.profileData.name)
                .font(.title2)
                .foregroundStyle(.text)
                .padding(.bottom, 60)
            
            ProfileSectionView(title: "Email", text: vm.profileData.email)
            
            ProfileSectionView(title: "Role", text: vm.profileData.role)
            
            ProfileSectionView(title: "Calls", text: "\(vm.profileData.callCount) calls")
            
            Button {
                authManager.logout()
            } label: {
                ButtonLabelView(label: "Logout")
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    ProfileView(authManager: AuthManager())
}
