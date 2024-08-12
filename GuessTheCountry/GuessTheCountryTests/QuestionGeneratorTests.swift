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

    func testGenerate10Questions() async throws {
        let sut = QuestionGenerator(countryService: CountryServiceMock(), itemGenerator: UniqueItemArrayGeneratorMock())

        let questions = try await sut.generateQuestions(count: 10)
        XCTAssertEqual(questions.count, 10)
    }

    func testGenerate20Questions() async throws {
        let sut = QuestionGenerator(countryService: CountryServiceMock(), itemGenerator: UniqueItemArrayGeneratorMock())

        let questions = try await sut.generateQuestions(count: 20)
        XCTAssertEqual(questions.count, 20)
    }

    func testCountriesArray () async throws {
        let serviceMock = CountryServiceMock()
        let allCountries = try await serviceMock.getCountries()
        let sut = RandomUniqueItemArrayGenerator()

        XCTAssertEqual(sut.getDistinct(items: allCountries, count: 10).count, 10)
    }

    func testGetDistincCountries() async throws {
        let service = CountryServiceMock()
        let itemGenerator = UniqueItemArrayGeneratorMock()
        let sut = QuestionGenerator(countryService: service, itemGenerator: itemGenerator)

        let questions = try await sut.generateQuestions(count: 1)

        guard let firstQuestion = questions.first else {
            XCTFail("Expected to have at least one question")
            return
        }

        let answers = Set(firstQuestion.possibleAnswers)

        XCTAssert(firstQuestion.possibleAnswers.allSatisfy { answers.contains($0) })
    }

    struct UniqueItemArrayGeneratorMock: UniqueItemArrayGenerator {
        func getDistinct<Element>(items: [Element], count: Int) -> [Element] {
            return Array(items.prefix(count))
        }
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
