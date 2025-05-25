//
//  LatestCallsView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct LatestCallsView: View {
    @ObservedObject var vm = LatestCallsVM()
    
    var body: some View {
        ScrollView {
            ForEach(vm.calls) { call in
                LogView(name: call.name, client: call.client.firstname, date: call.date)
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
