//
//  CallSectionView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import SwiftUI

struct CallSectionView: View {
    var title: String
    var icon: String
    var content: [String]

    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                SquareIconView(icon: icon)
                VStack (alignment: .leading) {
                    Text(title)
                        .foregroundStyle(.text)
                        .fontWeight(.medium)
                        .font(.title3)
                    Text("AI generated")
                        .foregroundStyle(.textLight)
                }
                Spacer()
            }
            .padding(.bottom, 5)
            
            if (content.count == 1) {
                Text(content[0])
                    .foregroundStyle(.text)
            } else {
                Text(content.map { "• \($0)" }.joined(separator: "\n"))
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.text)
            }
        }
        .padding()
//        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 7)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 1)
        )
        .padding(.horizontal, 20)
        .padding(.vertical, 10)

    }
}

#Preview {
    CallSectionView(
        title: "Temas clave", icon: "pencil", content: ["Decisiones", "Ayuda"])
    .padding()
}
