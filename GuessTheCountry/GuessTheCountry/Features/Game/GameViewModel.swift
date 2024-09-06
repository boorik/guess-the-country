//
//  GameViewModel.swift
//  GuessTheCountry
//
//  Created by ailton lopes mendes on 05/01/2024.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    init(game: Game, router: Router) {
        self.game = game
        self.router = router
        score = "0"
        self.process(gameState: game.state)
    }

    @Published var currentQuestion: Question?
    @Published var displayedHints: [DisplayedHint] = []
    @Published var answer: DisplayedCorrection?

    let game: Game
    let router: Router
    private(set) var score: String

    var possibleAnswers: [String] {
        currentQuestion?.possibleAnswers ?? []
    }

    var canDisplayNextHint: Bool {
        displayedHints.count < (currentQuestion?.hints.count ?? 0)
    }

    var nextHintButtonLabel: String {
        canDisplayNextHint ? "Indice suivant": "Vous avez le nombre maximum d'indices disponibles"
    }
    func onSelected(choice: String) {
        let gameState = game.selectAnswer(answer: choice)
        process(gameState: gameState)
    }

    func onNextHint() {
        process(gameState: game.revealMoreHints())
    }

    func isCorrectAnswer(countryName: String) -> Bool {
        answer == nil  || answer?.goodAnswer == countryName
    }

    private func isAnswerCorrect(answer: String) {
        // TODO: Créer la méthode qui va permettre à la vue d'afficher l'état de la réponse
    }

    func process(gameState: GameState) {
        answer = nil
        switch gameState {
        case let .answer(isCorrect, _, history):
            guard let lastQuestion = history.last else {
                return
            }
            answer = DisplayedCorrection(
                isCorrect: isCorrect,
                message: isCorrect ? "Bonne réponse" : "Mauvaise réponse",
                goodAnswer: lastQuestion.question.correctAnswer,
                givenAnswer: lastQuestion.response
            )
        case let .askingQuestion(question, score, hints):
            currentQuestion = question
            self.score = "\(score)"
            displayedHints = hints.map({ hint in
                return DisplayedHint(value: hint.value, label: hint.label, type: .fromModel(hint.type))
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

    func goToNextQuestion() {
        process(gameState: game.getNextQuestion())
    }
}
