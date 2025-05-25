//
//  CallController.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import Foundation

func fetchCalls(token: String, completion: @escaping (Result<[Call], Error>) -> Void) {
    guard let url = URL(string: "http://localhost:3000/api/app/calls") else {
        print("Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return
        }

        guard let data = data else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "No data", code: -1)))
            }
            return
        }

        do {
            let decoder = JSONDecoder()
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            decoder.dateDecodingStrategy = .custom { decoder in
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
            let calls = try decoder.decode([Call].self, from: data)
            DispatchQueue.main.async {
                completion(.success(calls))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }.resume()
}

