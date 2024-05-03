//
//  GameViewModel.swift
//  GuessTheCountry
//
//  Created by ailton lopes mendes on 05/01/2024.
//

import Foundation

struct DisplayedHint: Hashable, Identifiable {
    var id: String {
        value + label
    }
    
    let value: String
    let label: String
    let type: DisplayedHintType
}

enum DisplayedHintType {
    case image
    case text
}


class GameViewModel: ObservableObject {
    init(game: Game, router: Router) {
        self.game = game
        self.router = router
        score = "0"
        self.check(gameState: game.state)
    }
    
    @Published var currentQuestion: Question?
    @Published var displayedHints: [DisplayedHint] = []
    
    let game: Game
    let router: Router
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
    
    private func isAnswerCorrect(answer: String) {
        //TODO: Créer la méthode qui va permettre à la vue d'afficher l'état de la réponse
    }
    
    func check(gameState: GameState) {
        switch gameState {
        case .running(let question, let score, let hints, let history):
            currentQuestion = question
            self.score = "\(score)"
            displayedHints = hints.map({ hint in
                let displayedHintType = switch hint.type {
                case .image:
                    DisplayedHintType.image
                case .text, .number:
                    DisplayedHintType.text
                }
                return DisplayedHint(value: hint.value, label: hint.label, type: displayedHintType)
            })
        case .idle:
            currentQuestion = nil
        case .finished(let score):
            currentQuestion = nil
            router.navigate(to: .enGame(score))
        case .error:
            currentQuestion = nil
        }
    }

}
