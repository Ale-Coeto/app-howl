//
//  UploadSheetView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//
import SwiftUI

struct UploadSheetView: View {
    @Environment(\.dismiss) var quitView
    @ObservedObject var vm = UploadSheetVM()
    @Binding var selectedCall: Call?
    @Binding var openReport: Bool

    var body: some View {
        VStack {
            CircleIconView(icon: "square.and.arrow.up")
                .padding(.bottom, 30)

            TitleView(text: "Subir archivo")

            Text("Sube un archivo de audio o video para analizar la llamada.")
                .padding(.horizontal, 30)
                .padding(.bottom, 40)

            if vm.fileSelected {
                // Preview section
                VStack(alignment: .leading) {
                    Text("Cliente")
                        .fontWeight(.medium)
                        .foregroundStyle(.text)

                    ClientPickerView2(vm: vm)
                        .padding(.bottom)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                .padding(.top, 20)

                HStack {
                    Button {
                        vm.handleCancel()
                    } label: {
                        ButtonLabelView(
                            label: "Cancelar", primary: false, width: 140)
                    }

                    Button {
                        uploadFile()
                    } label: {
                        ButtonLabelView(label: "Subir archivo", width: 140)
                    }
                }
            } else {
                Button {
                    vm.showFileSelector = true
                } label: {
                    ButtonLabelView(label: "Seleccionar Archivo", width: 200)
                }
            }
        }
        .fileImporter(
            isPresented: $vm.showFileSelector,
            allowedContentTypes: [.audio, .mp3, .wav, .mpeg4Audio]
        ) { result in
            switch result {
            case .success(let file):
                let gotAccess = file.startAccessingSecurityScopedResource()
                if !gotAccess {
                    print("Failed to get access to the file")
                    return
                }

                vm.selectedFileURL = file
                vm.fileSelected = true
                file.stopAccessingSecurityScopedResource()

            case .failure(let error):
                print("File selection error:", error)
            }
        }

    }

    private func uploadFile() {
        guard let fileURL = vm.selectedFileURL,
            let clientId = vm.selectedClient?.id
        else {
            print("No file or client selected")
            return
        }

        let gotAccess = fileURL.startAccessingSecurityScopedResource()
        guard gotAccess else {
            print("Failed to access security scoped file")
            return
        }

        uploadFileCall(fileURL: fileURL, clientId: clientId) { result in
            // Stop access AFTER the upload finishes
            defer {
                fileURL.stopAccessingSecurityScopedResource()
            }

            switch result {
            case .success(let responseString):
                do {
                    guard let responseData = responseString.data(using: .utf8)
                    else {
                        print("Failed to convert response to Data")
                        return
                    }

                    // Print raw response for debugging
                    print("Raw response:", responseString)

                    let decoder = CustomDecoder.getInstance()

                    let callData = try decoder.decode(
                        Call.self, from: responseData)

                    DispatchQueue.main.async {
                        selectedCall = callData
                        openReport = true
                        quitView()
                    }
                } catch {
                    print("Decoding failed:", error)
                }

            case .failure(let error):
                print("Upload failed:", error.localizedDescription)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var call: Call? = nil
        @State private var open = false

        var body: some View {
            UploadSheetView(selectedCall: $call, openReport: $open)
        }
    }
    return PreviewWrapper()
}
//
//import SwiftUI
//
//struct UploadSheetView: View {
//    @Environment(\.dismiss) var quitView
//    @ObservedObject var vm = UploadSheetVM()
//
//    var body: some View {
//        VStack {
//            CircleIconView(icon: "square.and.arrow.up")
//                .padding(.bottom, 30)
//            TitleView(text: "Subir archivo")
//            Text("Sube un archivo de audio o video para analizar la llamada.")
//                .padding(.horizontal, 30)
//                .padding(.bottom, 40)
//
//            if vm.fileSelected {
//                //Preview
//
//                HStack {
//                    Button {
//                        vm.handleCancel()
//                    } label: {
//                        ButtonLabelView(label: "Cancelar", primary: false, width: 140)
//                    }
//                    Button {
//                        quitView()
//                    } label: {
//                        ButtonLabelView(label: "Subir archivo", width: 140)
//                    }
//                }
//
//            } else {
//                Button {
//                    vm.showFileSelector = true
//                } label: {
//                    ButtonLabelView(label: "Seleccionar Archivo", width: 200)
//                }
//            }
//
//        }
//        .fileImporter(
//            isPresented: $vm.showFileSelector,
//            allowedContentTypes: [.wav, .audio, .mp3]
////            allowsMultipleSelection: false
//
//        ) { result in
//             switch result {
//             case .success(let file):
//                 // gain access to the directory
//                 let gotAccess = file.startAccessingSecurityScopedResource()
//                 if !gotAccess { return }
//
//                 vm.handleFileSelected(file)
//                 // access the directory URL
//                 // (read templates in the directory, make a bookmark, etc.)
////                      onTemplatesDirectoryPicked(directory)
//                 // release access
//                 file.stopAccessingSecurityScopedResource()
//             case .failure(let error):
//                 // handle error
//                 print(error)
//             }
//        }
//    }
//}
//
//#Preview {
//    UploadSheetView()
//}
