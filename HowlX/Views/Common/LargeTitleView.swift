//
//  LargeTitle.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct LargeTitle: View {
    var text: String = ""
    var highlightedText: String = ""
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(.text)
                .fontWeight(.black)
                .font(.title)
            Text(highlightedText)
                .foregroundStyle(Color("Primary"))
                .fontWeight(.black)
                .font(.title)
        }
        
    }
}

#Preview {
    LargeTitle(text: "Análisis de", highlightedText: "Llamadas")
}
