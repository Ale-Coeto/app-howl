//
//  LoginView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginVM()
    
    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
            
            VStack {
                TitleView(text: "Login")
                
                VStack {
                    VStack (alignment: .leading) {
                        Text("Correo")
                        TextField("", text: $viewModel.email)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.emailAddress)
                            .textCase(.lowercase)
                            .disableAutocorrection(true)
                    }
                }
                
                VStack (alignment: .leading) {
                    Text("Contraseña")
                    TextField("", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.password)
                        .disableAutocorrection(true)
                }
                .padding(.bottom, 20)
                
                Button {
                    
                } label: {
                    Text("Login")
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 50)
                        .background(Color("Primary"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                
                HStack {
                    Text("Nuevo a HowlX?")
                        .foregroundStyle(Color("TextLight"))
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Regístrate")
                            .foregroundStyle(Color("PrimaryLight"))
                    }
                }
                .padding(.top)
                
                
                
            }
            .padding(30)
            .background(.white)
            .cornerRadius(10)
            .padding(40)
            
        }
    }
}

#Preview {
    LoginView()
}
