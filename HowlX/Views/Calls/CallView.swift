//
//  CallView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct CallView: View {
    @ObservedObject var vm = MainVM()
    
    var body: some View {
        ZStack {
            
            Color("BG")
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        VStack (alignment: .leading) {
                            LargeTitle(text: "Análisis de", highlightedText: "Llamadas")
                            Text("Mejorando el servicio al cliente")
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                   
                    HStack (spacing: 20) {
                        CallButtonView(info: vm.recordButton, action: vm.openRecording)
                        CallButtonView(info: vm.uploadButton, action: vm.openUpload)
                    }
                    .padding(.vertical, 20)
                    .padding()
                    
                }
                .padding()
                
                VStack (alignment: .leading) {
                    Text("Últimas Llamadas")
                        .padding(.horizontal, 30)
                        .fontWeight(.semibold)
                
                    LatestCallsView(selectedCall: $vm.selectedCall, openReport: $vm.showReportSheet)
                }
            }
        }
        .sheet(isPresented: $vm.showRecordingSheet) {
            RecordingSheetView(selectedCall: $vm.selectedCall, openReport: $vm.showReportSheet)
        }
        .sheet(isPresented: $vm.showUploadSheet) {
            UploadSheetView(selectedCall: $vm.selectedCall, openReport: $vm.showReportSheet)
        }
        .sheet(isPresented: $vm.showReportSheet) {
            if let call = vm.selectedCall {
                CallReportView(call: call)
            }
        }
    }
}

#Preview {
    CallView()
}
