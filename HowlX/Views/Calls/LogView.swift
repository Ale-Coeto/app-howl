//
//  Log.swift
//  HowlX
//
//  Created by Alejandra Coeto on 06/05/25.
//

import SwiftUI

struct LogView: View {
    var name: String = ""
    var client: String = ""
    var date: Date = Date()
    var companyName: String = ""
    
    var body: some View {
        
        HStack (){
            VStack (alignment: .leading) {
                Text(name)
                    .foregroundStyle(Color("Text"))
                Text(client)
                    .foregroundStyle(Color("TextLight"))
            }
            
            Spacer()
            
            VStack (alignment: .trailing) {
                Text(date.formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(Color("Primary"))
                
                Text(companyName)
                    .foregroundStyle(Color("PrimaryLight"))
            }
        }
        .padding(20)
        .background(.white)
        .cornerRadius(10)
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        
    }
}

#Preview {
    ZStack {
        Color(.gray)
        
        LogView(name: "Servicios", client: "Axteen", date: Date(), companyName: "Softek")
    }
}
