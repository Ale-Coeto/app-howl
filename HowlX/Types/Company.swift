//
//  Company.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import Foundation

struct Company: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    var clientSince: Date? = Date()
    var satisfaction: Int? = 1

    enum CodingKeys: String, CodingKey {
        case id, name, satisfaction
        case clientSince = "client_since"
    }
}
