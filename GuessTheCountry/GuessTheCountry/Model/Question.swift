//
//  Question.swift
//  GuessTheCountry
//
//  Created by Thessalène Jean-Louis on 08/12/2023.
//

import Foundation

struct Question: Equatable {
    let hints: [Hint]
    let correctAnswer: String
    let possibleAnswers: [String]
    
    func isAnswerCorrect(answer: String) -> Bool {
        correctAnswer == answer
    }
}

extension Question {
    
    static func mock(id: Int) -> Question {
        return Question(hints: [], correctAnswer: "Good Answer \(id)", possibleAnswers: ["Answer 1", "Answer 2", "Good Answer \(id)"])
    }
    
    static func mockArray(size : Int) -> [Question] {
        Array<Int>(1...size).map{ mock(id: $0) }
    }
}
