//
//  SignUpVM.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import Foundation

class SignUpVM: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    func validate() -> Bool {
        if name.count < 3 {
            errorMessage = "Nombre muy corto."
            return false
        }
        
        if !email.contains("@") {
            errorMessage = "Correo Inválido"
            return false
        }
        
        if password.count < 3 {
            errorMessage = "Contraseña muy corta"
            return false
        }
        
        return true
    }
    
    func signUp() {
        
    }
}
