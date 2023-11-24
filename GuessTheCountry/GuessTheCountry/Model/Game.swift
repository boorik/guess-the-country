//
//  Game.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation

class Game {
    internal init(score: Int = 0, questions: [Question], currentQuestionId: Int) {
        self.score = score
        self.questions = questions
        self.currentQuestionId = currentQuestionId
    }
    
    var score: Int = 0
    var questions: [Question]
    var currentQuestionId: Int
    
    func start(questionCount: Int) {
        //TODO
    }
    
    func onSelectAnswer(answer: String) {
        let currentQuestion = questions[currentQuestionId]
        
        if currentQuestion.isAnswerCorrect(answer: answer) {
            score += 1
        }
    }
}

struct Hint {
    let label: String
    let value: String
}

struct Question {
    let hints: [Hint]
    let correctAnswer: String
    let possibleAnswers: [String]
    
    func isAnswerCorrect(answer: String) -> Bool {
        correctAnswer == answer
    }
}
