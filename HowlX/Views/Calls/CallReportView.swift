//
//  CallSheetView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import SwiftUI

struct CallReportView: View {
    var call: Call
    
    var body: some View {
        VStack {
            LargeTitle(text: "Llamada", highlightedText: call.name)
            
            ScrollView {
                
                if call.mainIdeas.count > 0 {
                    CallSectionView(title: "Temas clave", icon: "list.bullet", content: call.mainIdeas)
                }
                
                if let feedback = call.feedback {
                    CallSectionView(title: "Retroalimentación", icon: "bubble", content: [feedback])
                }
               
                if let emotions = call.sentimentAnalysis {
                    CallSectionView(title: "Sentimiento", icon: "doc.text", content: [emotions])
                }
                
                if let result = call.output {
                    CallSectionView(title: "Resultado", icon: "doc.text", content: [result])
                }
                
                if call.riskWords.count > 0 {
                    CallSectionView(title: "Palabras de riesgo", icon: "doc.text", content: call.riskWords)
                }
                
                if let summary = call.summary {
                    CallSectionView(title: "Resumen", icon: "doc.text", content: [summary])
                }
            }
        
        }
        .padding(.top, 40)
    }
}

#Preview {
    CallReportView(call: sampleCall)
}
