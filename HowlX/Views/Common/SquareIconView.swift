//
//  SquareIconView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import SwiftUI

struct SquareIconView: View {
    var icon: String
    var size: CGFloat = 50
    
    var body: some View {
        ZStack(alignment: .center) {

            RoundedRectangle(cornerRadius: 10)
                .fill(Color("Primary").opacity(0.2))
                .frame(width: size, height: size)
                .overlay {
                    Image(systemName: icon)
                        .foregroundStyle(Color("Primary"))
                        .font(.title2)
                }

        }
    }
}

#Preview {
    SquareIconView(icon: "pencil")
}
