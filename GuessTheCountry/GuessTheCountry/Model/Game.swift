//
//  Game.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation

enum GameState: Equatable {
    case running
    case finished(score: Int)
}

class Game {
    internal init(score: Int = 0, questions: [Question]) throws {
        self.score = score
        self.questions = questions
        guard let firstQuestion = questions.first else {
            throw GameError.noQuestionsProvided
        }
        self.currentQuestion = firstQuestion
        self.currentQuestionId = 0;
    }
    
    var state: GameState = .running
    var score: Int = 0
    var questions: [Question]
    var currentQuestion: Question
    var currentQuestionId: Int
    
    func finish() {
        state = .finished(score: score)
    }
    
    func onSelectAnswer(answer: String) {
        guard state == .running else {
            return
        }
        
        if currentQuestion.isAnswerCorrect(answer: answer) {
            score += 1
        }
        guard questions.last != currentQuestion else {
            finish()
            return
        }
        currentQuestionId += 1
        currentQuestion = questions[currentQuestionId]
    }
}

struct Hint: Equatable {
    let label: String
    let value: String
}

enum GameError: Error {
    case noQuestionsProvided
}
