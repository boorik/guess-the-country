//
//  QuestionGenerator.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation

class QuestionGenerator {
    internal init(countryService: CountryService, itemGenerator: any UniqueItemArrayGenerator) {
        self.countryService = countryService
        self.itemGenerator = itemGenerator
    }
    
    let countryService: CountryService
    let itemGenerator: any UniqueItemArrayGenerator
    
    func generateQuestions(count: Int) async throws -> [Question] {
        
        //TODO récupérer 5 bonnes réponses
        // pour chaque question, ajouter 1 bonne réponse + 3 mauvaises
        
        let allCountries = try await countryService.getCountries()
        let countries = itemGenerator.getDistinct(items: allCountries, count: count)
        
        return countries.map{ country in
            var correctAnswer = country.name.common
            var possibleAnswers = itemGenerator.getDistinct(items: allCountries, count: 4).map { $0.name.common }
            
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

protocol UniqueItemArrayGenerator {
    func getDistinct<Element>(items: [Element], count: Int) -> [Element]
}

struct RandomUniqueItemArrayGenerator: UniqueItemArrayGenerator {
    func getDistinct<Element>(items: [Element], count: Int) -> [Element] {
        Array(items.shuffled().prefix(count))
    }
}
