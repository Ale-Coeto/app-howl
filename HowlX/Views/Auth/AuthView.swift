//
//  AuthView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 25/05/25.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Rectangle()
                        .fill(.BG)
                        .frame(width: 700, height: 600)
                        .rotationEffect(.degrees(12))
                        .offset(y: -110)
                    Spacer()
                }

                VStack {
                    Spacer()

                    VStack {
                        Text("HowlX")
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.bottom, 20)

                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                    }
                    .padding(.bottom, 200)

                    Spacer()
                }

                VStack {

                    Spacer()

                    // TODO: make button width not fixed
                    VStack(spacing: 20) {

                        LargeTitle(
                            text: "Análisis de ", highlightedText: "Llamadas"
                        )
                        .padding(.bottom, 35)

                        NavigationLink {
                            LoginView(authManager: authManager)
                        } label: {
                            ButtonLabelView(label: "Login", width: 300)
                        }

                        NavigationLink {
                            SignUpView(authManager: authManager)
                        } label: {
                            ButtonLabelView(
                                label: "Registro", primary: false, width: 300)
                        }

                    }

                }
                .padding()
            }
        }
    }
}

#Preview {
    AuthView(authManager: AuthManager())
}
