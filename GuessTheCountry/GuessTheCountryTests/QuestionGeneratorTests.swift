//
//  QuestionGeneratorTests.swift
//  GuessTheCountryTests
//
//  Created by ippon on 10/11/2023.
//

import XCTest
@testable import GuessTheCountry

enum QuestionGeneratorTestsError: Error {
    case fileNotFound
}

final class QuestionGeneratorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGenerateQuestions() async throws {
        let sut = QuestionGenerator(countryService: CountryServiceMock())
        
        let questions = try await sut.generateQuestions(count: 10)
        XCTAssertEqual(questions.count, 10)
    }
    
    func testCountriesArray () async throws {
        let serviceMock = CountryServiceMock()
        let sut = try await serviceMock.getCountries()
        
        XCTAssertEqual(sut.get(count: 10).count, 10)
        
    }

    class CountryServiceMock: CountryService {
        func getCountries() async throws -> [GuessTheCountry.Country] {
            
            let bundle = Bundle(for: type(of: self))
            guard let url = bundle.url(forResource: "countries.json", withExtension: nil) else {
                throw QuestionGeneratorTestsError.fileNotFound
            }
            
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Country].self, from: data)
        }
    }
}
