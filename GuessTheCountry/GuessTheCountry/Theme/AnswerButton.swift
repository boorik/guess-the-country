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
            .padding(12)
            .foregroundStyle(Color.white)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(theme.answerButtonColor)
            )
    }
}
