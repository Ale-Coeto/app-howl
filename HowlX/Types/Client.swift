//
//  User.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import Foundation

struct Client: Codable, Identifiable, Hashable, Equatable {
    let id: Int
    let firstname: String
    let lastname: String
    let email: String
    let companyId: Int
    let company: Company

    enum CodingKeys: String, CodingKey {
        case id, firstname, lastname, email, company
        case companyId = "company_id"
    }
}
