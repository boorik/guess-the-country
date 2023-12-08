//
//  Game.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation

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
    
    var score: Int = 0
    var questions: [Question]
    var currentQuestion: Question
    var currentQuestionId: Int
    
    func finish() {
        // TODO
    }
    
    func onSelectAnswer(answer: String) {
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

struct Question: Equatable {
    let hints: [Hint]
    let correctAnswer: String
    let possibleAnswers: [String]
    
    func isAnswerCorrect(answer: String) -> Bool {
        correctAnswer == answer
    }
}

enum GameError: Error {
    case noQuestionsProvided
}
