//
//  UserData.swift
//  HowlX
//
//  Created by Alejandra Coeto on 28/05/25.
//

import Foundation

struct UserDetails: Codable, Identifiable {
    let id: String
    let email: String
    let name: String
    let callCount: Int
    let role: String
    
}
