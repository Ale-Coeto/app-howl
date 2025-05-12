//
//  CallButton.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import SwiftUI

struct CallButtonView: View {
    var info: CallButton
    var action: () -> ()
    
    var body: some View {
        VStack {
            Text(info.title)

            ZStack(alignment: .center) {

                Circle()
                    .fill(Color("Primary").opacity(0.2))
                    .frame(width: 50)
                    .overlay {
                        Image(systemName: info.icon)
                            .foregroundStyle(Color("Primary"))
                            .font(.title2)
                    }

            }
            .padding(5)

            Button {
                action()
            } label: {
                ButtonLabelView(label: info.buttonLabel)
            }
        }
        .frame(width: 150)
        .padding(.vertical, 10)
        .overlay {
            RoundedRectangle(cornerRadius: 10).stroke(
                Color("Primary"), lineWidth: 1)
        }

    }
}

#Preview {
    CallButtonView(info: CallButton(title: "", buttonLabel: "", icon: ""), action: {
        
    })
}
