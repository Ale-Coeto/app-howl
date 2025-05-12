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
    
    var body: some View {
        VStack {
            CircleIconView(icon: "square.and.arrow.up")
                .padding(.bottom, 30)
            TitleView(text: "Subir archivo")
            Text("Sube un archivo de audio o video para analizar la llamada.")
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            
            if vm.fileSelected {
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
                    vm.showFileSelector = true
                } label: {
                    ButtonLabelView(label: "Seleccionar Archivo", width: 200)
                }
            }
            
        }
        .fileImporter(
            isPresented: $vm.showFileSelector,
            allowedContentTypes: [.wav, .audio, .mp3]
//            allowsMultipleSelection: false
            
        ) { result in
             switch result {
             case .success(let file):
                 // gain access to the directory
                 let gotAccess = file.startAccessingSecurityScopedResource()
                 if !gotAccess { return }
                 
                 vm.handleFileSelected(file)
                 // access the directory URL
                 // (read templates in the directory, make a bookmark, etc.)
//                      onTemplatesDirectoryPicked(directory)
                 // release access
                 file.stopAccessingSecurityScopedResource()
             case .failure(let error):
                 // handle error
                 print(error)
             }
        }
    }
}

#Preview {
    UploadSheetView()
}
