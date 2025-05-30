//
//  CustomDecoder.swift
//  HowlX
//
//  Created by Alejandra Coeto on 30/05/25.
//

import Foundation

class CustomDecoder {
    static private var decoder: JSONDecoder?
    
    static func getInstance() -> JSONDecoder {
        if (self.decoder == nil) {
            self.decoder = JSONDecoder()
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [
                .withInternetDateTime, .withFractionalSeconds,
            ]

            decoder!.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)
                if let date = formatter.date(from: dateStr) {
                    return date
                } else {
                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Invalid date format: \(dateStr)"
                    )
                }
            }
        }
        
        return self.decoder!
    }
    
    
}
