//
//  Session.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import Foundation
import Security

func saveTokenToKeychain(token: String) {
    let tokenData = token.data(using: .utf8)!
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "authToken",
        kSecValueData as String: tokenData
    ]

    SecItemDelete(query as CFDictionary)
    SecItemAdd(query as CFDictionary, nil)
}

func loadTokenFromKeychain() -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "authToken",
        kSecReturnData as String: true,
        kSecMatchLimit as String: kSecMatchLimitOne
    ]

    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)

    guard status == errSecSuccess, let tokenData = item as? Data else {
        return nil
    }

    return String(data: tokenData, encoding: .utf8)
}

func deleteTokenFromKeychain() {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "authToken" 
    ]

    let status = SecItemDelete(query as CFDictionary)
    if status == errSecSuccess {
        print("Token deleted successfully")
    } else if status == errSecItemNotFound {
        print("Token not found")
    } else {
        print("Failed to delete token with status: \(status)")
    }
}
