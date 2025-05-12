//
//  NewRecordingView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct RecordingSheetView: View {
    @Environment(\.dismiss) var quitView
    @ObservedObject var vm = RecordingSheetVM()
    
    var body: some View {
        VStack {
            CircleIconView(icon: "microphone.fill")
                .padding(.bottom, 30)
            TitleView(text: "Grabar llamada")
            Text("Sube un archivo de audio o video para analizar la llamada.")
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            
            if vm.hasRecording {
                //Preview
                
                HStack {
                    Button {
                        vm.handleCancel()
                    } label: {
                        ButtonLabelView(label: "Cancelar", primary: false, width: 140)
                    }
                    Button {
                        quitView()
                    } label: {
                        ButtonLabelView(label: "Subir archivo", width: 140)
                    }
                }
                
            } else {
                Button {
//                    vm.showFileSelector = true
                } label: {
                    ButtonLabelView(label: "Seleccionar Archivo", width: 200)
                }
            }
            
        }
    }
}

#Preview {
    RecordingSheetView()
}
