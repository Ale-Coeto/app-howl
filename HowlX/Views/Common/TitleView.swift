//
//  TitleView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct TitleView: View {
    var text: String  = ""
    var body: some View {
        Text(text)
            .font(.title2)
            .fontWeight(.medium)
            .padding(.bottom, 10)
    }
}

#Preview {
    TitleView()
}
