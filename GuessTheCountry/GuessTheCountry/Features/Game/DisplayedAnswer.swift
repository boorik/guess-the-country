//
//  DisplayedAnswer.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 23/08/2024.
//

import Foundation

struct DisplayedAnswer: Identifiable {
    let id = UUID()
    let isCorrect: Bool
    let message: String
    let goodAnswer: String
    let givenAnswer: String
}

extension DisplayedAnswer {
    static var mock: DisplayedAnswer {
        DisplayedAnswer(isCorrect: true, message: "Bonne réponse", goodAnswer: "42", givenAnswer: "42")
    }
}
