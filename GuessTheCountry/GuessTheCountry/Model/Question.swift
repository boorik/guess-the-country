//
//  Question.swift
//  GuessTheCountry
//
//  Created by Thessalène Jean-Louis on 08/12/2023.
//

import Foundation

struct Question: Equatable, Hashable {
    let hints: [Hint]
    let correctAnswer: String
    let possibleAnswers: [String]
    
    func isAnswerCorrect(answer: String) -> Bool {
        correctAnswer == answer
    }
}

extension Question {
    
    static func mock(id: Int) -> Question {
        return Question(
            hints: [Hint(label: "\(id)hint1", value: "\(id)hint1"), Hint(label: "\(id)hint2", value: "\(id)hint2")],
            correctAnswer: "Good Answer \(id)",
            possibleAnswers: ["Answer 1", "Answer 2", "This is a long river answer where I don't where it's here... But you know what it's still an anwser :D", "Good Answer \(id)"]
        )
    }
    
    static func mockArray(size : Int) -> [Question] {
        Array<Int>(1...size).map{ mock(id: $0) }
    }
}
