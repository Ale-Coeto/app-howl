//
//  TranscriptView.swift
//  HowlX
//
//  Created by Alejandra Coeto on 30/05/25.
//

import SwiftUI

struct TranscriptView: View {
    let title: String
    let icon: String
    let transcript: [DiarizedTranscript]
    
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
            
            VStack (alignment:.leading){
                ForEach(transcript, id: \.self) { transcript in
                    VStack (alignment: .leading) {
                        Text(transcript.speaker)
                            .foregroundStyle(Color("Primary"))
                            .fontWeight(.medium)
                        
                        Text(transcript.text)
                            .foregroundStyle(.text)
                    }
                    .padding(.bottom)
                }
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
    TranscriptView(title: "Trans", icon: "pen.fill", transcript: [DiarizedTranscript(speaker: "Juan", text: "Hello"), DiarizedTranscript(speaker: "Pepe", text: "Goodbye")])
}
