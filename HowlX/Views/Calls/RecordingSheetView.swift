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
    @Binding var selectedCall: Call?
    @Binding var openReport: Bool
    
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
                    Text("Nombre")
                        .fontWeight(.medium)
                        .foregroundStyle(.text)
                    
                    TextField("", text: $vm.name)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.emailAddress)
                        .textCase(.lowercase)
                        .autocorrectionDisabled(true)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                .padding(.top, 20)
                
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
                        uploadRecording()
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
    
    func uploadRecording() {

        let fileURL = vm.audioFileURL

        guard let clientId = vm.selectedClient?.id else {
            print("No id")
            return
        }

        uploadCallRecording(fileURL: fileURL, clientId: clientId) { result in
            switch result {
            case .success(let response):
                
                DispatchQueue.main.async {
                    do {
                        guard let responseData = response.data(using: .utf8)
                        else {
                            print("Failed to convert response string to Data")
                            return
                        }
                        print(String(data: responseData, encoding: .utf8) ?? "Invalid data")

                        let decoder = JSONDecoder()
                        let formatter = ISO8601DateFormatter()
                        formatter.formatOptions = [
                            .withInternetDateTime, .withFractionalSeconds,
                        ]

                        decoder.dateDecodingStrategy = .custom { decoder in
                            let container = try decoder.singleValueContainer()
                            let dateStr = try container.decode(String.self)
                            if let date = formatter.date(from: dateStr) {
                                return date
                            } else {
                                throw DecodingError.dataCorruptedError(
                                    in: container,
                                    debugDescription: "Invalid date format: \(dateStr)"
                                )
                            }
                        }
                        let callData = try decoder.decode(
                            Call.self, from: responseData)
                        
                        selectedCall = callData
                        openReport = true
                        print("Upload successful, ID: \(callData.id)")
                    } catch {
                        print(
                            "Failed to decode response: \(error)"
                            
                        )
                    }
                }

                print("Upload successful: \(response)")
            case .failure(let error):
                print("Upload failed: \(error.localizedDescription)")
            }
        }

    }
    
    
}

#Preview {
    struct PreviewWrapper: View {
        @State private var call:Call? = sampleCall
        @State private var open = false

            var body: some View {
                ZStack {
                    Color("BG").ignoresSafeArea()
                    RecordingSheetView(selectedCall: $call, openReport: $open)
                }
            }
        }

        return PreviewWrapper()
    
}
