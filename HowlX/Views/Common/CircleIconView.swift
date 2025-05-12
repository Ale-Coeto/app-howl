//
//  CircleIcon.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import SwiftUI

struct CircleIconView: View {
    var icon: String

    var body: some View {
        ZStack(alignment: .center) {

            Circle()
                .fill(Color("Primary").opacity(0.2))
                .frame(width: 50)
                .overlay {
                    Image(systemName: icon)
                        .foregroundStyle(Color("Primary"))
                        .font(.title2)
                }

        }
    }
}

#Preview {
    CircleIconView(icon: "")
}
