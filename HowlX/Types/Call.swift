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
    let satisfaction: Int?
    let duration: Int
    let summary: String?
    let date: Date
    let transcript: String?
    let mainIdeas: [String]
    let type: String?
    let consultantID: Int
    let clientID: Int
    let feedback: String?
    let sentimentAnalysis: String?
    let riskWords: [String]
    let output: String?
    let diarizedTranscript: [DiarizedTranscript]?
    let name: String
    let client: ClientCall?

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

struct ClientCall: Codable {
    let id: Int
    let firstname: String
    let lastname: String
    var company: Company? = nil
}

let sampleCall = Call(
    id: 150,
    context: nil,
    satisfaction: nil,
    duration: 0,
    summary: "Hello, this is the summary for the call",
    date: ISO8601DateFormatter().date(from: "2025-05-25T00:00:00.000Z") ?? Date(),
    transcript: nil,
    mainIdeas: ["Problema con compu"],
    type: "Sin categoría",
    consultantID: 27,
    clientID: 6,
    feedback: nil,
    sentimentAnalysis: nil,
    riskWords: [],
    output: nil,
    diarizedTranscript: [
        DiarizedTranscript(
            speaker: "SPEAKER_00",
            text: "Hola, este es una llamada de el servicio al cliente porque tengo un problema con mi computadora y no sirve y no me ayudan y ya me enojé. No me han ayudado en mucho mucho tiempo."
        )
    ],
    name: "recording.m4a",
    client: ClientCall(
        id: 6,
        firstname: "Juan",
        lastname: "Pérez",
        company: Company(id: 1, name: "Softek", clientSince: Date(), satisfaction: 3)
    )
)
