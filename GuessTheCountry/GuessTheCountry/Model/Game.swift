//
//  Game.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation

enum GameState: Equatable {
    static func == (lhs: GameState, rhs: GameState) -> Bool {
        switch lhs {
        case .idle:
            if case .idle = rhs {
                return true
            }
        case .askingQuestion(let lquestion, let lscore, let lhints):
            if case .askingQuestion(let rquestion, let rscore, let rhints) = rhs {
                return lquestion == rquestion && lscore == rscore && lhints == rhints
            }
        case .answer(let lisCorrect, let lscore, let lhistory):
            if case .answer(let risCorrect, let rscore, let rhistory) = rhs {
                return lisCorrect == risCorrect && rscore == lscore && lhistory == rhistory
            }
        case .finished(let lscore):
            if case .finished(let rscore) = rhs {
                return lscore == rscore
            }
        case .error(let lerror):
            if case .error(let rerror) = rhs {
                return lerror.localizedDescription == rerror.localizedDescription
            }
        }
        return false
    }
    
    case idle
    //case running(question: Question, score: Int, hints: [Hint], history: [HistoryElement])
    case askingQuestion(question: Question,score: Int, hints: [Hint])
    case answer(isCorrect: Bool, score: Int, history: [HistoryElement])
    case finished(score: Int)
    case error(Error)
}

extension GameState {
    var isRunning: Bool {
        switch self {
        case .askingQuestion, .answer:
            true
        case .finished, .idle, .error:
            false
        }
    }
    
    var isAnswerDisplayed: Bool {
        switch self {
        case .answer:
            true
        case .askingQuestion, .finished, .idle, .error:
            false
        }
    }
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

enum GameError: Error, Equatable {
    case noQuestionsProvided
    case hintsOutOfBounds
    case unexpectedCall
}

class Game {
    internal init(score: Int = 0, questions: [Question]) {
        self.score = score
        self.questions = questions
        self.state = .idle
        self.history = []
        if let firstQuestion = questions.first, let firstHint = firstQuestion.hints.first {
            self.state = .askingQuestion(question: firstQuestion, score: self.score, hints: [firstHint])
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
    private var history: [HistoryElement]

    
    func finish() -> GameState {
        state = .finished(score: score)
        return state
    }
    
    func selectAnswer(answer: String) -> GameState {
        guard case .askingQuestion(let currentQuestion, _, _) = state else {
            return state
        }
        
        history.append(HistoryElement(response: answer, question: currentQuestion, hintUsed: numberRevealedHints))
        
        let isCorrect = currentQuestion.isAnswerCorrect(answer: answer)
        if isCorrect {
            score += 1// TODO impact numberRevealedHints on the score
        }
        // check if game is over
        guard questions.last != currentQuestion else {
            return finish()
        }
       
        state = .answer(isCorrect: isCorrect, score: score, history: history)
        
        return state
    }
    
    private func revealHints() throws -> [Hint] {
        guard state.isRunning else {
            throw GameError.unexpectedCall
        }
        guard currentQuestionId < questions.count else {
            throw GameError.hintsOutOfBounds
        }
        numberRevealedHints += 1
        return Array(questions[currentQuestionId].hints.prefix(numberRevealedHints))
    }
    
    func revealMoreHints() -> GameState {
        guard case .askingQuestion(let currentQuestion, _, _) = state else {
            return state
        }
        do {
            let newHints = try revealHints()
            state = .askingQuestion(question: currentQuestion, score: score, hints: newHints)
        } catch {
            return .error(error)
        }
        return state
    }
    
    func getNextQuestion() -> GameState {
        guard currentQuestionId < questions.count else {
            return finish()
        }
        
        currentQuestionId += 1
        numberRevealedHints = 0
        let currentQuestion = questions[currentQuestionId]
        
        do {
            let newHints = try revealHints()
            state = .askingQuestion(question: currentQuestion, score: score, hints: newHints)
        } catch {
            return .error(error)
        }
        return state
    }
}
