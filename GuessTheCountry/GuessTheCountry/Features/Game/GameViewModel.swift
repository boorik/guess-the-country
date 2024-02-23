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
        score = "0"
        self.check(gameState: game.state)
    }
    
    @Published var currentQuestion: Question?
    @Published var displayedHints: [DisplayedHint] = []
    
    let game: Game
    private (set) var score: String
    
    var possibleAnswers: [String] {
        currentQuestion?.possibleAnswers ?? []
    }
    
    var canDisplayNextHint: Bool {
        displayedHints.count < (currentQuestion?.hints.count ?? 0)
    }
    
    func check(answer: String) {
        let gameState = game.selectAnswer(answer: answer)
        check(gameState: gameState)
    }
    
    func onNextHint() {
        check(gameState: game.revealMoreHints())
    }
    
    func check(gameState: GameState) {
        switch gameState {
        case let .running(question, score, hints):
            currentQuestion = question
            self.score = "\(score)"
            displayedHints = hints.map({ hint in
                    DisplayedHint(
                        value: hint.value,
                        label: hint.label
                    )
                })
        case .idle:
            currentQuestion = nil
        case .finished:
            currentQuestion = nil
        case .error:
            currentQuestion = nil
        }
    }

}
