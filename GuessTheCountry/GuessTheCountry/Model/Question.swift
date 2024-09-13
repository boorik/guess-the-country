//
//  Question.swift
//  GuessTheCountry
//
//  Created by Thessalène Jean-Louis on 08/12/2023.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Hashable, Equatable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.latitude)
        hasher.combine(self.longitude)
    }
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && rhs.longitude == lhs.longitude
    }
}

struct CountryData: Equatable, Hashable {
    static func == (lhs: CountryData, rhs: CountryData) -> Bool {
        lhs.name == rhs.name
    }
    
    let name: String
    let location: CLLocationCoordinate2D
}

struct Question: Equatable, Hashable {
    let hints: [Hint]
    let correctAnswer: CountryData
    let possibleAnswers: [String]

    func isAnswerCorrect(answer: String) -> Bool {
        correctAnswer.name == answer
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
            correctAnswer: CountryData(name: "Good Answer \(id)", location: .london),
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
