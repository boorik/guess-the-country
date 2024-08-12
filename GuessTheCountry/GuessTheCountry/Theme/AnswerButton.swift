//
//  AnswerButton.swift
//  GuessTheCountry
//
//  Created by Dan PEROCHEAU on 08/03/2024.
//

import SwiftUI

struct AnswerButton: ButtonStyle {
    internal init(theme: Theme, correctAnswer: Bool = true, givenAnswer: Bool =  false) {
        self.theme = theme
        self.correctAnswer = correctAnswer
        self.isGivenAnswer = givenAnswer
    }

    let theme: Theme
    let correctAnswer: Bool
    let isGivenAnswer: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.buttonText)
            .padding(12)
            .foregroundStyle(theme.answerButtonForegroundColor)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(correctAnswer ? theme.answerButtonColor : .red)
                    .stroke(isGivenAnswer ? .black : .clear, lineWidth: 4)
            )
    }
}
