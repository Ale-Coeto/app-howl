//
//  UploadSheetVM.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import Foundation

class UploadSheetVM: ObservableObject {
    @Published var showFileSelector = false
    @Published var fileSelected = true
    
    func handleFileSelected(_ file: URL) {
        fileSelected = true
    }
    
    func handleCancel() {
        fileSelected = false
    }
//    @State var showFileSelector = false
//    @State var fileSelected = false
}
