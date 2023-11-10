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
    
    func generateQuestions(count: Int) -> [Question] {
        []
    }
}
