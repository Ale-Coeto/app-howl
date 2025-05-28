//
//  UserData.swift
//  HowlX
//
//  Created by Alejandra Coeto on 28/05/25.
//

import Foundation

struct UserDetails: Codable, Identifiable {
    let id: Int
    let email: String
    let name: String
    let callCount: Int
    let role: String
    
    init() {
        self.id = 0
        self.email = ""
        self.name = ""
        self.callCount = 0
        self.role = ""
    }
}
