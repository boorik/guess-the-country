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
    
    func onSelectAnswer(answerId: Int) {
        let currentQuestion = questions[currentQuestionId]
        
        if currentQuestion.isAnswerCorrect(answerId: answerId) {
            score += 1
        }
    }
}

struct Question {
    var hints: [String]
    var correctAnswer: Int
    var possibleAnswers: [String]
    
    func isAnswerCorrect(answerId: Int) -> Bool {
        correctAnswer == answerId
    }
}
