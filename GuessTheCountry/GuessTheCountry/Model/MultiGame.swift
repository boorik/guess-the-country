//
//  Game.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation

class MultiGame {
    internal init(
        questions: [Question],
        scoreCalculator: ScoreCalculator = ScoreCalculatorUsingPercentage(),
        playerList: [Player]
    ) {
        self.scoreCalculator = scoreCalculator
        self.questions = questions
        self.state = .idle
        self.history = []
        self.playerList = playerList
        if let firstQuestion = questions.first, let firstHint = firstQuestion.hints.first {
            self.state = .askingQuestion(question: firstQuestion, score: self.score, hints: [firstHint])
            numberRevealedHints = 1
        } else {
            self.state = .error(GameError.incompleteQuestionData)
        }
    }
    
    private var scores: Dictionary<Player, Int> = [:]
    private var questions: [Question]
    private var currentQuestionId: Int = 0
    private var numberRevealedHints: Int = 0
    private(set) var state: GameState
    private var history: [HistoryElement]
    private let scoreCalculator: ScoreCalculator
    private let playerList: [Player]

    func finish() -> MultiGameState {
        state = .finished(score: score)
        return state
    }

    func selectAnswer(answer: String, player: Player) -> GameState {
        guard case .askingQuestion(let currentQuestion, _, _) = state else {
            return state
        }

        history.append(HistoryElement(response: answer, question: currentQuestion, hintUsed: numberRevealedHints))

        let isCorrect = currentQuestion.isAnswerCorrect(answer: answer)
        if isCorrect {
            score += scoreCalculator.incrementScore(indicesUsedCount: numberRevealedHints)
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

    private func revealMoreHints() -> MultiGameState {
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

    func getNextQuestion() -> MultiGameState {
        currentQuestionId += 1

        guard currentQuestionId < questions.count else {
            return finish()
        }

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

struct GameTurn {
    
}

typealias PlayerID = String

struct Player: Hashable {
    let playerID : PlayerID
}
