//
//  LatestCallsView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct LatestCallsView: View {
    var logs = [
        Log(id: 1, name: "Test", client: "Softek", date: Date()),
        Log(id: 2, name: "Test", client: "Softek", date: Date()),
        Log(id: 3, name: "Test", client: "Softek", date: Date()),
        Log(id: 4, name: "Test", client: "Softek", date: Date()),
        Log(id: 5, name: "Test", client: "Softek", date: Date()),
    ]
    
    var body: some View {
        ScrollView {
            ForEach(logs) { log in
                LogView(name: log.name, client: log.client, date: log.date)
            }
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    ZStack {
        Color("BG")
        LatestCallsView()
    }
}
