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
        
        let countries = try await countryService.getCountries().get(count: count)
        
        return countries.map{ country in
            var correctAnswer = country.name.common
            var possibleAnswers = countries.get(count: 4).map { $0.name.common }
            
            possibleAnswers.append(correctAnswer)
            return Question(
                hints: [
                    Hint(label: "flag", value: country.flag),
                    Hint(label:  "capital", value: country.capital?.first ?? "Unknown")
                ],
                correctAnswer: correctAnswer,
                possibleAnswers: possibleAnswers // $0 prend le 1er paramètre retourné pour chaque itération
            )
        }
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
