//
//  MultiGameState.swift
//  GuessTheCountry
//
//  Created by ippon on 13/12/2024.
//

import Foundation

enum MultiGameState: Equatable {
    static func == (lhs: MultiGameState, rhs: MultiGameState) -> Bool {
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
    case askingQuestion(question: Question, scores: [Player:Int], hints: [Hint])
    case answer(isCorrect: Bool, scores: [Player:Int], history: [HistoryElement])
    case finished(scores: [Player:Int])
    case error(Error)
}

extension MultiGameState {
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
