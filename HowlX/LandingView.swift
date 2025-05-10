//
//  ContentView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(Color("Primary"))
                Text("HowlX")
                
                VStack {
                    NavigationLink {
                        LoginView()
                    } label: {
                        Text("Login")
                            .frame(width: 150)
                            .foregroundStyle(.white)
                            .padding(.vertical, 8)
//                            .padding(.horizontal, 50)
                            .background(Color("Primary"))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Registro")
                            .frame(width: 150)
                            .foregroundStyle(Color("Primary"))
                            .padding(.vertical, 8)
//                            .padding(.horizontal, 50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 30).stroke(Color("Primary"), lineWidth: 2)
                            }
                    }
                    
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    LandingView()
}
