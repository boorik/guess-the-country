//
//  CountryServiceTests.swift
//  GuessTheCountryTests
//
//  Created by Yannick JACQUELINE on 27/10/2023.
//

import XCTest
@testable import GuessTheCountry

final class CountryServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() async throws {
        let sut = CountryService(session: .shared)
        let result = try await sut.getCountries()
        XCTAssertEqual(result.count, 250)
    }

}
