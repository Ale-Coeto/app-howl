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
        if email == "" || password == "" {
            error = "Email o contraseña vacíos"
            return
        }

        guard let url = URL(string: BACKEND_URL + "/api/app/auth/login") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        email = email.lowercased()

        let body: [String: String] = [
            "email": email,
            "password": password,
        ]

        request.httpBody = try? JSONEncoder().encode(body)

        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data,
                let httpResponse = response as? HTTPURLResponse
            else {
                completion(
                    .failure(NSError(domain: "Invalid response", code: 0)))
                return
            }

            if httpResponse.statusCode == 200 {
                do {
                    let decoded = try JSONDecoder().decode(
                        LoginResponse.self, from: data)
                    completion(.success(decoded.token))
                } catch {
                    completion(.failure(error))
                }
            } else {
                do {
                    let errorResponse = try JSONDecoder().decode(
                        ErrorResponse.self, from: data)
                    completion(
                        .failure(
                            NSError(
                                domain: "Login", code: httpResponse.statusCode,
                                userInfo: [
                                    NSLocalizedDescriptionKey: errorResponse
                                        .error
                                ])))
                } catch {
                    completion(.failure(error))  // fallback in case decoding fails
                }
            }
        }

        task.resume()

    }

    private func invalidateTokenOnServer() {
        guard let url = URL(string: BACKEND_URL + "/api/auth/logout") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Add authorization header if token exists
        if let token = loadTokenFromKeychain() {
            request.setValue(
                "Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        URLSession.shared.dataTask(with: request).resume()
    }

}
