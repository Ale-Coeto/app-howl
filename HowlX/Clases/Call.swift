//
//  Call.swift
//  HowlX
//
//  Created by Alejandra Coeto on 10/05/25.
//

import Foundation

struct Call: Codable, Identifiable {
    let id: Int
    let context: String?
    let satisfaction: Int
    let duration: Int
    let summary: String
    let date: Date
    let transcript: String?
    let mainIdeas: [String]
    let type: String
    let consultantID: Int
    let clientID: Int
    let feedback: String
    let sentimentAnalysis: String
    let riskWords: [String]
    let output: String
    let diarizedTranscript: [DiarizedTranscript]
    let name: String
    let client: Client

    enum CodingKeys: String, CodingKey {
        case id, context, satisfaction, duration, summary, date, transcript
        case mainIdeas = "main_ideas"
        case type
        case consultantID = "consultant_id"
        case clientID = "client_id"
        case feedback, sentimentAnalysis = "sentiment_analysis"
        case riskWords = "risk_words"
        case output
        case diarizedTranscript = "diarized_transcript"
        case name, client
    }
}

struct DiarizedTranscript: Codable {
    let speaker: String
    let text: String
}

struct Client: Codable {
    let id: Int
    let firstname: String
    let lastname: String
}

    
