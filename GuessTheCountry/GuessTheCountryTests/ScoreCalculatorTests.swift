//
//  Untitled.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 13/09/2024.
//

import Testing
@testable import GuessTheCountry

struct ScoreCalculatorTests {
    @Test("Score with percentage works")
    func testPercentage() {
        let sut = ScoreCalculatorUsingPercentage()
        #expect(sut.incrementScore(indicesUsedCount: 1) == 100)
        #expect(sut.incrementScore(indicesUsedCount: 2) == 50)
        #expect(sut.incrementScore(indicesUsedCount: 3) == 33)
    }
}
