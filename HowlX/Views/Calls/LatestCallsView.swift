//
//  LatestCallsView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct LatestCallsView: View {
    @ObservedObject var vm = LatestCallsVM()
    @Binding var selectedCall: Call?
    @Binding var openReport: Bool
    
    var body: some View {
        ScrollView {
            ForEach(vm.calls) { call in
                Button {
                    selectedCall = call
                    openReport = true
                } label: {
                    LogView(name: call.name, client: call.client.firstname + call.client.lastname, date: call.date, companyName: call.client.company?.name ?? "")
                }
                
            }
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var mockCall: Call? = sampleCall
        @State private var mockOpen = true
            var body: some View {
                ZStack {
                    Color("BG").ignoresSafeArea()
                    LatestCallsView(selectedCall: $mockCall, openReport: $mockOpen)
                }
            }
        }

        return PreviewWrapper()
}
