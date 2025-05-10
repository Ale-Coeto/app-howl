//
//  SubtitleView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct SubtitleView: View {
    var text: String = ""
    
    var body: some View {
        Text(text)
            .font(.title3)
            .fontWeight(.medium)
            .padding(.bottom, 20)
    }
}

#Preview {
    SubtitleView()
}
