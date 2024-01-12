//
//  Game.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation

enum GameState {
    case running(Question)
    case finished(score: Int)
    case error(Error)
}

class Game {
    internal init(score: Int = 0, questions: [Question]) {
        self.score = score
        self.questions = questions
        if let firstQuestion = questions.first {
            self.state = .running(firstQuestion)
        } else {
            self.state = .error(GameError.noQuestionsProvided)
        }
    }
    
    var score: Int = 0
    var questions: [Question]
    var currentQuestionId: Int = 0
    var numberRevealedHints: Int = 0
    var state: GameState

    
    func finish() {
        state = .finished(score: score)
    }
    
    func onSelectAnswer(answer: String) -> GameState {
        guard case .running(let currentQuestion) = state else {
            return state
        }
        
        
        if currentQuestion.isAnswerCorrect(answer: answer) {
            score += 1 // TODO impact numberRevealedHints on the score
            // TODO reset gameViewModel.displayedHints to [] in a specific method
        }
        guard questions.last != currentQuestion else {
            finish()
            return .finished(score: score)
        }
        currentQuestionId += 1
        state = .running(questions[currentQuestionId])
        return state
    }
    
    func revealMoreHints() -> [Hint] {
        guard case .running(let currentQuestion) = state else {
            return []
        }
        numberRevealedHints += 1
        return Array(currentQuestion.hints.prefix(numberRevealedHints))
    }
}

struct Hint: Equatable, Hashable {
    let label: String
    let value: String
}

enum GameError: Error {
    case noQuestionsProvided
}
