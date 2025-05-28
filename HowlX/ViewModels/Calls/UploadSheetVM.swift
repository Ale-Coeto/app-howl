//
//  UploadSheetVM.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import Foundation

class UploadSheetVM: ObservableObject {
    @Published var showFileSelector = false
    @Published var fileSelected = false
    @Published var selectedFileURL: URL?
    @Published var selectedClient: Client?
    @Published var clients: [Client] = [] // Populate this with your clients
    
    init() {
        guard let token = loadTokenFromKeychain() else {
            print("No token available")
            return
        }

        fetchClients(token: token) { result in
            switch result {
            case .success(let clients):
                print("Fetched \(clients.count) clients")
                DispatchQueue.main.async {
                    self.clients = clients
                    //                    self.selectedClient = clients.first!
                }
            // Update your state or UI here
            case .failure(let error):
                print("Error fetching calls: \(error)")
            }
        }

    }
    
    func handleFileSelected(_ file: URL) {
        selectedFileURL = file
        fileSelected = true
    }
    
    func handleCancel() {
        selectedFileURL = nil
        fileSelected = false
    }
    
    // Helper functions for client display
    func getDisplayName(_ client: Client?) -> String {
        guard let client = client else { return "" }
        return "\(client.firstname) \(client.lastname)"
    }
    
    func getCompanyName(_ client: Client?) -> String {
        client?.company.name ?? ""
    }
}
