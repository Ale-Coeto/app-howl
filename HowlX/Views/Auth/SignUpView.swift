//
//  RegistrationView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel = SignUpVM()
    @ObservedObject var authManager: AuthManager
    
    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
            
            VStack {
                TitleView(text: "Registro")
                
                if viewModel.errorMessage != "" {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                        .padding(.bottom)
                }
                VStack {
                    VStack (alignment: .leading) {
                        Text("Nombre")
                        TextField("", text: $viewModel.name)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
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
                    if viewModel.validate() {
                        viewModel.signUp()
                    }
                } label: {
                    Text("Registro")
                        .foregroundStyle(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 50)
                        .background(Color("Primary"))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                
                
                HStack {
                    Text("¿Ya tienes una cuenta?")
                        .foregroundStyle(Color("TextLight"))
                        .font(.system(size: 15))
                    
                    NavigationLink {
//                        LoginView()
                    } label: {
                        Text("Inicia sesión")
                            .foregroundStyle(Color("PrimaryLight"))
                            .font(.system(size: 16))
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
    SignUpView(authManager: AuthManager())
}
