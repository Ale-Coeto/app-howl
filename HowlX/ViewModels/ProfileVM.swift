//
//  ProfileVM.swift
//  HowlX
//
//  Created by Alejandra Coeto on 28/05/25.
//

import Foundation

class ProfileVM: ObservableObject {
    var profileData: UserDetails = UserDetails()
    
    init() {
        fetchUserDetails() { result in
            switch result {
            case .success(let data):
                print("Got token")
                DispatchQueue.main.async {
                    self.profileData = data
                }
                
            case .failure(let error):
                print("No user data found", error)
            }
        }
    }
}
