//
//  MainVM.swift
//  HowlX/Users/alecoeto/Documents/Swift/HowlX/HowlX/Views/Calls/CallView.swift
//
//  Created by Alejandra Coeto on 06/05/25.
//

import Foundation

struct CallButton {
    var title: String
    var buttonLabel: String
    var icon: String

}

class MainVM: ObservableObject {
    @Published var showRecordingSheet = false
    @Published var showUploadSheet = false
    
    
    var uploadButton = CallButton(title: "Nueva Llamada", buttonLabel: "Grabar", icon: "microphone.fill")
    
    var callButton = CallButton(title: "Subir archivo", buttonLabel: "Subir", icon: "square.and.arrow.up")
    
    func openRecording() {
        showRecordingSheet = true
    }
    
    func openUpload() {
        showUploadSheet = true
    }
}
