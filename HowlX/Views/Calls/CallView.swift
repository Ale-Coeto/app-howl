//
//  CallView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct CallView: View {
    @ObservedObject var viewModel = MainVM()
    
    var body: some View {
        ZStack {
            
            Color("BG")
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        LargeTitle(text: "Análisis de", highlightedText: "Llamadas")
                        Spacer()
                    }
                    .padding(.horizontal)
                   
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Subir llamada")
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        
                        Button {
                            viewModel.showRecordingSheet = true
                        } label : {
                            Text("Nueva llamada")
                                .foregroundStyle(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 30).stroke(.white, lineWidth: 2)
                                }
                        }
                    }
                    .padding(30)
                    .background(Color("Primary"))
                    .cornerRadius(10)
                    .padding()
                }
                .padding()
                
                VStack (alignment: .leading) {
                    Text("Últimas Llamadas")
                        .padding(.horizontal, 30)
                        .fontWeight(.semibold)
                
                    LatestCallsView()
                }
            }
        }
        .sheet(isPresented: $viewModel.showRecordingSheet) {
            RecordingSheetView()
        }
    }
}

#Preview {
    CallView()
}
