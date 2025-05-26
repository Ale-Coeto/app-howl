//
//  CallController.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import Foundation

func fetchCalls(
    token: String, completion: @escaping (Result<[Call], Error>) -> Void
) {
    guard let url = URL(string: BACKEND_URL + "/api/app/calls/getCalls") else {
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
            formatter.formatOptions = [
                .withInternetDateTime, .withFractionalSeconds,
            ]

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

func uploadCallRecording(
    fileURL: URL,
    clientId: Int,
    completion: @escaping (Result<String, Error>) -> Void
) {
    guard let url = URL(string: BACKEND_URL + "/api/app/calls/analyzeCall") else {
        print("Invalid URL")
        return
    }
    
    guard let token = loadTokenFromKeychain() else {
        print("Invalid Token")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let boundary = UUID().uuidString
    request.setValue(
        "multipart/form-data; boundary=\(boundary)",
        forHTTPHeaderField: "Content-Type")

    var data = Data()


    // Add clientId
    data.append("--\(boundary)\r\n".data(using: .utf8)!)
    data.append(
        "Content-Disposition: form-data; name=\"clientId\"\r\n\r\n".data(
            using: .utf8)!)
    data.append("\(clientId)\r\n".data(using: .utf8)!)

    // Add audio file
    let filename = "recording.m4a"
    let mimetype = "audio/m4a"

    do {
        let fileData = try Data(contentsOf: fileURL)

        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append(
            "Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n"
                .data(using: .utf8)!)
        data.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        data.append(fileData)
        data.append("\r\n".data(using: .utf8)!)
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
    } catch {
        DispatchQueue.main.async {
            print("filedata error")
            completion(.failure(error))
        }
        return
    }

    request.httpBody = data

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            DispatchQueue.main.async {
                completion(
                    .failure(NSError(domain: "Invalid response", code: -1)))
            }
            return
        }

        if httpResponse.statusCode == 200, let data = data {
            let responseString =
                String(data: data, encoding: .utf8) ?? "No response string"
            DispatchQueue.main.async {
                completion(.success(responseString))
            }
        } else {
            let statusError = NSError(
                domain: "Upload failed",
                code: httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey: "Unexpected server response"
                ]
            )
            DispatchQueue.main.async {
                completion(.failure(statusError))
            }
        }
    }.resume()
}
