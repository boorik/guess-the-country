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
            let correctAnswer = country.name.common
            var possibleAnswers = itemGenerator.getDistinct(items: allCountries, count: 3).map { $0.name.common }
            possibleAnswers.append(correctAnswer)
            possibleAnswers.shuffle()
            
            return Question(
                hints: [
                    Hint(label: "flag", value: country.flag),
                    Hint(label: "capital", value: country.capital?.first ?? "Unknown"),
                    Hint(label: "population", value: "\(country.population)"),
                    Hint(label: "continents", value: "\(country.continents.map{ $0.rawValue }.joined(separator: ", "))")
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
