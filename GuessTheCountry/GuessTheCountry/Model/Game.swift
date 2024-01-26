//
//  Game.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation

enum GameState {
    case idle
    case running(question: Question, score: Int, hints: [Hint])
    case finished(score: Int)
    case error(Error)
}

class Game {
    internal init(score: Int = 0, questions: [Question]) {
        self.score = score
        self.questions = questions
        self.state = .idle
        if let firstQuestion = questions.first, let firstHint = firstQuestion.hints.first {
            self.state = .running(question: firstQuestion, score: self.score, hints: [firstHint])
            numberRevealedHints = 1
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
    
    func selectAnswer(answer: String) -> GameState {
        guard case .running(let currentQuestion, _, _) = state else {
            return state
        }
        
        
        if currentQuestion.isAnswerCorrect(answer: answer) {
            score += 1 // TODO impact numberRevealedHints on the score
            // TODO reset gameViewModel.displayedHints to [] in a specific method
        }
        guard questions.last != currentQuestion else {
            finish()
            return state
        }
        currentQuestionId += 1
        numberRevealedHints = 0
        state = .running(question: questions[currentQuestionId], score: score, hints: revealHints())
        return state
    }
    
    private func revealHints() -> [Hint] {
        guard case .running(let currentQuestion, _, _) = state else {
            return []
        }
        numberRevealedHints += 1
        return Array(currentQuestion.hints.prefix(numberRevealedHints))
    }
    
    func revealMoreHints() -> GameState {
        guard case .running(let currentQuestion, _, _) = state else {
            return state
        }
        state = .running(question: currentQuestion, score: score, hints: revealHints())
        return state
    }
}

struct Hint: Equatable, Hashable {
    let label: String
    let value: String
}

enum GameError: Error {
    case noQuestionsProvided
}
