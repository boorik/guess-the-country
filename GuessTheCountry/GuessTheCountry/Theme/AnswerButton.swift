//
//  AnswerButton.swift
//  GuessTheCountry
//
//  Created by Dan PEROCHEAU on 08/03/2024.
//

import SwiftUI

struct AnswerButton: ButtonStyle {
    let theme: Theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.buttonText)
            .padding(12)
            .foregroundStyle(theme.answerButtonForegroundColor)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(theme.answerButtonColor)
            )
    }
}
