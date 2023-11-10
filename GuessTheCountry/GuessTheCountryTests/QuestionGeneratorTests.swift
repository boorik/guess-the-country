//
//  QuestionGeneratorTests.swift
//  GuessTheCountryTests
//
//  Created by ippon on 10/11/2023.
//

import XCTest
@testable import GuessTheCountry

final class QuestionGeneratorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let sut = QuestionGenerator(countryService: CountryServiceMock())
    }

    struct CountryServiceMock: CountryService {
        func getCountries() async throws -> [GuessTheCountry.Country] {
            []
        }
    }
}
