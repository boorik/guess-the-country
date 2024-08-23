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

    static func mock(id: Int, hintsNumber: Int = 4) -> Question {
        return Question(
            hints: [Int](1...hintsNumber).map {
                Hint(
                    label: "Indice \($0) de la question \(id)",
                    value: "\($0)",
                    type: .text
                )
            },
            correctAnswer: "Good Answer \(id)",
            possibleAnswers: [
                "Answer 1",
                "Answer 2",
                "Royaume Uni de Grande Bretagne et d'Irlande",
                "Good Answer \(id)"
            ].shuffled()
        )
    }

    static func mockArray(size: Int, hintsNumber: Int = 4) -> [Question] {
        var questions = [Question]()
        for id in 1...size {
            questions.append(mock(id: id, hintsNumber: hintsNumber))
        }
        return questions
    }
}
