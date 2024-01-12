//
//  GameViewModel.swift
//  GuessTheCountry
//
//  Created by ailton lopes mendes on 05/01/2024.
//

import Foundation

struct DisplayedHint: Hashable {
    let value: String
    let label: String
}

class GameViewModel: ObservableObject {
    internal init(game: Game) {
        self.game = game
        currentQuestion = game.questions.first
    }
    
    @Published var currentQuestion: Question?
    @Published var displayedHints: [DisplayedHint] = []
    
    let game: Game
    var score: String {
        "\(game.score)"
    }
    
    var possibleAnswers: [String] {
        currentQuestion?.possibleAnswers ?? []
    }
    
    func check(answer: String) {
        let gameState = game.onSelectAnswer(answer: answer)
        switch gameState {
        case .running(let question):
            currentQuestion = question
        case .finished(let score):
            currentQuestion = nil
        case .error(let error):
            currentQuestion = nil
        }
    }
    
    func onNextHint() {
        displayedHints = game.revealMoreHints().map({ hint in
            DisplayedHint(
                value: hint.value,
                label: hint.label
            )
        })
    }
}
