//
//  AnswerButton.swift
//  GuessTheCountry
//
//  Created by Dan PEROCHEAU on 08/03/2024.
//

import SwiftUI

struct AnswerButton: ButtonStyle {
    let theme: Theme
    let isCorrectAnswer: Bool
    let isGivenAnswer: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.buttonText)
            .padding(12)
            .foregroundStyle(theme.answerButtonForegroundColor)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(isCorrectAnswer ? theme.answerButtonColor : .red)
                    .stroke(isGivenAnswer ? .black : .clear, lineWidth: 4)
            )
    }
}

extension AnswerButton {
    init(theme: Theme, isCorrectAnswer: Bool = true, givenAnswer: Bool =  false) {
        self.theme = theme
        self.isCorrectAnswer = isCorrectAnswer
        self.isGivenAnswer = givenAnswer
    }
}
