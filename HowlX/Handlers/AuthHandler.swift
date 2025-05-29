//
//  AuthHandler.swift
//  HowlX
//
//  Created by Alejandra Coeto on 28/05/25.
//

import Foundation


func verifyToken(completion: ((Bool) -> Void)? = nil) {
    guard let token = loadTokenFromKeychain() else {
        DispatchQueue.main.async {
            completion?(false)
        }
        return
    }

    guard let url = URL(string: BACKEND_URL + "/api/app/auth/verify") else {
        DispatchQueue.main.async {
            completion?(false)
        }
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let body = ["token": token]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Verify token error:", error)
            DispatchQueue.main.async {
                completion?(false)
            }
            return
        }

        guard let data = data else {
            DispatchQueue.main.async {
                completion?(false)
            }
            return
        }

        do {
            let result = try JSONDecoder().decode(TokenVerificationResponse.self, from: data)
            DispatchQueue.main.async {
                completion?(result.valid)
            }
        } catch {
            print("Token decoding error:", error)
            DispatchQueue.main.async {
                completion?(false)
            }
        }
    }.resume()
}

func fetchUserDetails(completion: @escaping (Result<UserDetails, Error>) -> Void) {
    guard let token = loadTokenFromKeychain() else {
        DispatchQueue.main.async {
            completion(.failure(NSError(domain: "Token not valid", code: -1)))
        }
        return
    }
    guard let url = URL(string: BACKEND_URL + "/api/app/auth/getUserDetails") else {
//        completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    // Add token if needed, for example:
    // request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

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

        let decoder = JSONDecoder()

        do {
            let user = try decoder.decode(UserDetails.self, from: data)
            DispatchQueue.main.async {
                completion(.success(user))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }.resume()
}
