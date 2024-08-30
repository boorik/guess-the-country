//
//  DisplayedCorrection.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 23/08/2024.
//

import Foundation

struct DisplayedCorrection: Identifiable {
    let id = UUID()
    let isCorrect: Bool
    let message: String
    let goodAnswer: String
    let givenAnswer: String
}

extension DisplayedCorrection {
    static var mock: DisplayedCorrection {
        DisplayedCorrection(isCorrect: true, message: "Bonne réponse", goodAnswer: "42", givenAnswer: "42")
    }
}
