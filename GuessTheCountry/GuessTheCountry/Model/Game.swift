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

struct Hint: Equatable, Hashable {
    let label: String
    let value: String
    let type: HintType
}

enum HintType {
    case image
    case text
    case number
}

enum GameError: Error {
    case noQuestionsProvided
    case hintsOutOfBounds
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
    
    private var score: Int = 0
    private var questions: [Question]
    private var currentQuestionId: Int = 0
    private var numberRevealedHints: Int = 0
    private(set) var state: GameState

    
    func finish() {
        state = .finished(score: score)
    }
    
    func selectAnswer(answer: String) -> GameState {
        guard case .running(let currentQuestion, _, _) = state else {
            return state
        }
        
        if currentQuestion.isAnswerCorrect(answer: answer) {
            score += 1 // TODO impact numberRevealedHints on the score
        }
        guard questions.last != currentQuestion else {
            finish()
            return state
        }
        currentQuestionId += 1
        numberRevealedHints = 0
        do {
            state = try .running(question: questions[currentQuestionId], score: score, hints: revealHints())
        } catch {
            return .error(error)
        }
        return state
    }
    
    private func revealHints() throws -> [Hint] {
        guard case .running(_, _, _) = state else {
            return []
        }
        guard currentQuestionId < questions.count else {
            throw GameError.hintsOutOfBounds
        }
        numberRevealedHints += 1
        return Array(questions[currentQuestionId].hints.prefix(numberRevealedHints))
    }
    
    func revealMoreHints() -> GameState {
        guard case .running(let currentQuestion, _, _) = state else {
            return state
        }
        do {
            state = try .running(question: currentQuestion, score: score, hints: revealHints())
        } catch {
            return .error(error)
        }
        return state
    }
}
