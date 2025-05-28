//
//  AuthManager.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import Foundation

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var showLogin = true

    init() {
        verifyToken { isValid in
            DispatchQueue.main.async {
                self.isLoggedIn = isValid
            }
        }
    }
    

    func handleLoginSuccess(token: String) {
        saveTokenToKeychain(token: token)
        isLoggedIn = true
    }


    func logout() {
        deleteTokenFromKeychain()
//        invalidateTokenOnServer()
        isLoggedIn = false
    }
}
