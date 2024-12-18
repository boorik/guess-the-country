//
//  QuestionGenerator.swift
//  GuessTheCountry
//
//  Created by ippon on 10/11/2023.
//

import Foundation
import CoreLocation

class QuestionGenerator {
    internal init(countryService: CountryService, itemGenerator: any UniqueItemArrayGenerator) {
        self.countryService = countryService
        self.itemGenerator = itemGenerator
    }

    let countryService: CountryService
    let itemGenerator: any UniqueItemArrayGenerator

    func generateQuestions(count: Int) async throws -> [Question] {

        // TODO récupérer 5 bonnes réponses
        // pour chaque question, ajouter 1 bonne réponse + 3 mauvaises

        let allCountries = try await countryService.getCountries()
        let countries = itemGenerator.getDistinct(items: allCountries, count: count)

        return countries.map { country in

            let correctAnswer = CountryData(
                name: country.name.common,
                location: CLLocationCoordinate2D(
                    latitude: country.latlng[0],
                    longitude: country.latlng[1]
                )
            )
            var possibleAnswers = itemGenerator.getDistinct(items: allCountries, count: 3).map { $0.name.common }
            possibleAnswers.append(correctAnswer.name)
            possibleAnswers.shuffle()

            return Question(
                hints: [
                    Hint(label: "flag", value: country.flags.png, type: .image),
                    Hint(label: "capital", value: country.capital?.first ?? "Unknown", type: .text),
                    Hint(label: "population", value: "\(country.population)", type: .number),
                    Hint(
                        label: "continents",
                        value: "\(country.continents.map { $0.rawValue }.joined(separator: ", "))",
                        type: .text
                    )
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
