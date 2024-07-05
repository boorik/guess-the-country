//
//  AnswerPopover.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 05/07/2024.
//

import SwiftUI

struct AnswerPopover: View {
    let answer: DisplayedAnswer
    let onButtonTapped: () -> Void
    let theme = Theme.default
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.25)
            VStack {
                Text("\(answer.message)")
                    .padding()
                Button {
                    onButtonTapped()
                } label: {
                    Text("Question suivante")
                        .multilineTextAlignment(.center)
                        .frame(minHeight: 90, maxHeight: 90)
                }
                .buttonStyle(AnswerButton(theme: theme))
            }
            .padding(24)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }
}

#Preview {
    AnswerPopover(answer: DisplayedAnswer.mock, onButtonTapped: {})
}
