//
//  Call.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import Foundation

class Call: Identifiable {
    var id: Int
    var summary: String
    var satisfaction: Int
    var duration: Int
    var date: Date
    var mainIdeas: [String]
    var type: String
    var consultant_id: Int
    var feedback: String?
    var sentimentAnalysis: String
    
    init(id: Int, summary: String, satisfaction: Int, duration: Int, date: Date, mainIdeas: [String], type: String, consultant_id: Int, feedback: String? = nil, sentimentAnalysis: String) {
        self.id = id
        self.summary = summary
        self.satisfaction = satisfaction
        self.duration = duration
        self.date = date
        self.mainIdeas = mainIdeas
        self.type = type
        self.consultant_id = consultant_id
        self.feedback = feedback
        self.sentimentAnalysis = sentimentAnalysis
    }
    
    var sampleCall = Call(id: 1, summary: "Call about performance test done poorly", satisfaction: 8, duration: 10, date: Date(), mainIdeas: ["Performance", "poorly done"], type: "Testing", consultant_id: 1, sentimentAnalysis: "Happy")
}
    
    
//    id                 Int             @id(map: "call_pkey") @default(autoincrement())
//      context            String?
//      satisfaction       Int?
//      duration           Int
//      summary            String?
//      date               DateTime        @db.Date
//      transcript         String?
//      main_ideas         String[]
//      type               String?         @db.VarChar(50)
//      consultant_id      Int?
//      client_id          Int?
//      feedback           String?
//      sentiment_analysis String?
//      risk_words         String?
//      output             String?
//      call_emotions      call_emotions[]
//      client             client?         @relation(fields: [client_id], references: [id], onUpdate: NoAction, map: "call_client_id_fkey")
//      consultant         consultant?

