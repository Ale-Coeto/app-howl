//
//  ProfileSectionView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 28/05/25.
//

import SwiftUI

struct ProfileSectionView: View {
    var title: String = ""
    var text: String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            TitleView(text: title)
            
            Text(text)
                .foregroundStyle(.textLight)
        }
        .padding(.bottom)
    }
}

#Preview {
    ProfileSectionView(title: "Email", text: "ale@tec.mx")
}
