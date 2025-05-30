//
//  LoginView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var vm = LoginVM()
    @ObservedObject var authManager: AuthManager
    
    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
            
            VStack {
                TitleView(text: "Login")
                
                if (vm.error != "") {
                    Text(vm.error)
                        .foregroundStyle(.red)
                        .padding(.bottom)
                }
                
                VStack {
                    VStack (alignment: .leading) {
                        Text("Correo")
                        TextField("", text: $vm.email)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled(true)
                    }
                }
                
                VStack (alignment: .leading) {
                    Text("Contraseña")
                    SecureField("", text: $vm.password)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.password)
                        .autocorrectionDisabled(true)
                }
                .padding(.bottom, 20)
                
                Button {
                    vm.login() { result in
                        switch result {
                        case .success(let token):
                            print("Got token")
                            DispatchQueue.main.async {
                                authManager.handleLoginSuccess(token: token)
                            }
                           
                        case .failure(let error):
                            print("Login failed:", error)
                            DispatchQueue.main.async {
                                vm.error = error.localizedDescription
                            }
                        }
                    }
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
                        SignUpView(authManager: authManager)
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
    LoginView(authManager: AuthManager())
}
