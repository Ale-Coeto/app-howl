//
//  LatestCallsVM.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import Foundation

class LatestCallsVM: ObservableObject {
    @Published var calls: [Call] = []
    @Published var error: String = ""
    
    init() {
        guard let token = loadTokenFromKeychain() else {
            print("No token available")
            return
        }
        
        fetchCalls(token: token) { result in
            switch result {
            case .success(let calls):
                print("Fetched \(calls.count) calls")
                self.calls = calls
                // Update your state or UI here
            case .failure(let error):
                print("Error fetching calls: \(error)")
            }
        }
    }
}
