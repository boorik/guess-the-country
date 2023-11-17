//
//  QuestionGenerator.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation

class QuestionGenerator {
    internal init(countryService: CountryService) {
        self.countryService = countryService
    }
    
    let countryService: CountryService
    
    func generateQuestions(count: Int) async throws -> [Question] {
        
        //TODO récupérer 5 bonnes réponses
        // pour chaque question, ajouter 1 bonne réponse + 3 mauvaises
        
//        let countries = try await countryService.getCountries()
//        countries.map{ country in
//            Question(
//                hints: [],
//                correctAnswer: 0,
//                possibleAnswers: countries.get(count: 4))
//        }
        return []
    }
    
}

extension [Country] {
    
    func get(count: Int) -> [Country] {
        Array<Int>(0..<count)
            .compactMap { _ in
                self.randomElement()
            }
    }
}
