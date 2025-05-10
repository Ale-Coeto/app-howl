//
//  NewRecordingView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct RecordingSheetView: View {
    var body: some View {
        VStack {
            TitleView(text: "Nueva Llamada")
            
            SubtitleView(text: "Grabar")
            Text("Graba una nueva llamada con el micrófono de tu teléfono")
            
            SubtitleView(text: "Subir archivo")
            Text("Sube un archivo de audio o video para analizar la llamada")
        }
    }
}

#Preview {
    RecordingSheetView()
}
