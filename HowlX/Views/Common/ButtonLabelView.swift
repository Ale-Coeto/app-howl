//
//  ButtonLabelView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import SwiftUI

struct ButtonLabelView: View {
    var label: String = ""
    var primary: Bool = true
    var width: CGFloat = 100
    
    var body: some View {
        
        if primary {
            Text(label)
                .frame(width: width)
                .foregroundStyle(.white)
                .padding(.vertical, 8)
                .background(Color("Primary"))
                .clipShape(RoundedRectangle(cornerRadius: 30))
        } else {
            
            Text(label)
                .frame(width: width)
                .foregroundStyle(Color("Primary"))
                .padding(.vertical, 8)
                .overlay {
                    RoundedRectangle(cornerRadius: 30).stroke(
                        Color("Primary"), lineWidth: 2)
                }
        }
    }
}

#Preview {
    ButtonLabelView(label: "Hi")
}
