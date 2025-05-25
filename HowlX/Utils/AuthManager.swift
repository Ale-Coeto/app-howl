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
        checkToken()
    }

    func checkToken() {
        if let token = loadTokenFromKeychain() {
            isLoggedIn = true
            print(token)

        } else {
            isLoggedIn = false
        }
    }

    func handleLoginSuccess(token: String) {
        saveTokenToKeychain(token: token)
        isLoggedIn = true
    }

    func logout() {
        deleteTokenFromKeychain()
        isLoggedIn = false
    }
}
