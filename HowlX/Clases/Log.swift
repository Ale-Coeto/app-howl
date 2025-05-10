//
//  Log.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import Foundation

class Log: Identifiable {
    var id: Int
    var name: String
    var client: String
    var date: Date
    
    init(id: Int, name: String, client: String, date: Date) {
        self.id = id
        self.name = name
        self.client = client
        self.date = date
    }
}
