//
//  RecordingSheetVM.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import Foundation

class RecordingSheetVM: ObservableObject {
    @Published var hasRecording = false
    
    func handleCancel() {
        hasRecording = false
    }
}
