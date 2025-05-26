//
//  LoginVM.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String
}

class LoginVM: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    
    func login(completion: @escaping (Result<String, Error>) -> Void) {
        if (email == "" || password == "") {
            error = "Email o contraseña vacíos"
        }
        
        guard let url = URL(string: BACKEND_URL + "/api/auth/login") else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0)))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let body: [String: String] = [
                "email": email,
                "password": password
//                "email": "admin@tec.mx",
//                "password": "123456#A"
            ]

            request.httpBody = try? JSONEncoder().encode(body)

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "No data returned", code: 0)))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
                    completion(.success(decoded.token))
                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        
    }
    
}
