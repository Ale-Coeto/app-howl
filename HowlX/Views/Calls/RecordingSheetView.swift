//
//  NewRecordingView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI
import AVFoundation

struct RecordingSheetView: View {
    @Environment(\.dismiss) var quitView
    @ObservedObject var vm = RecordingSheetVM()
    
    var body: some View {
        VStack {
            
            // Recording done
            if vm.hasRecording {
                
                TitleView(text: "Vista Previa")
                
                Text("Verifica y sube la grabación.")
                    .padding(.horizontal, 30)
                    .padding(.bottom, 40)
                
                HStack () {
                    Text("Grabación")
                        .fontWeight(.medium)
                        .foregroundStyle(.text)
                    Spacer()
                }
                .padding(.horizontal, 40)
                
                Button(action: vm.togglePlayback) {
                    CircleIconView(icon: vm.isPlaying ? "stop.fill" : "play.fill")
                }
                
                ProgressView(value: vm.playbackProgress, total: 1.0)
                    .accentColor(Color("Primary"))
                    .padding()
                    .padding(.bottom)
                    .padding(.horizontal, 30)
                
                VStack (alignment: .leading) {
                    Text("Cliente")
                        .fontWeight(.medium)
                        .foregroundStyle(.text)
                    
                    ClientPickerView(vm: vm)
                        .padding(.bottom)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                .padding(.top, 20)
                
                HStack {
                    Button {
                        vm.handleCancel()
                    } label: {
                        ButtonLabelView(label: "Cancelar", primary: false, width: 140)
                    }
                    Button {
                        vm.uploadRecording()
                        quitView()
                    } label: {
                        ButtonLabelView(label: "Subir grabación", width: 140)
                    }
                }
                
            } else {
                
                // Stop recording
                if vm.isRecording {
                    CircleIconView(icon: "record.circle")
                        .padding(.bottom, 30)
                    
                    TitleView(text: "Grabando audio")
                    
                    Text("Se está grabando el audio.")
                        .padding(.horizontal, 30)
                        .padding(.bottom, 40)
                    
                    Button {
                        vm.stopRecording()
                    } label: {
                        ButtonLabelView(label: "Parar", width: 200)
                    }
                    
                // Start recording
                } else {
                    
                    CircleIconView(icon: "microphone.fill")
                        .padding(.bottom, 30)
                    
                    TitleView(text: "Grabar audio")
                    
                    Text("Comienza a grabar con tu teléfono.")
                        .padding(.horizontal, 30)
                        .padding(.bottom, 40)
                    
                    
                    Button {
                        vm.startRecording()
                    } label: {
                        ButtonLabelView(label: "Grabar", width: 200)
                    }
                    
                }
                
                
                
                
            }
            
            
        }
    }
    
    
}

#Preview {
    RecordingSheetView()
}
