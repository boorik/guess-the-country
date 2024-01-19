//
//  GameTests.swift
//  GuessTheCountryTests
//
//  Created by ippon on 19/01/2024.
//

import XCTest

@testable import GuessTheCountry
final class GameTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGivenNewGameWhenInitiatedThenStateIsRunning() throws {
        let sut = Game(questions: Question.mockArray(size: 5))
        
        guard case .running(let currentQuestion, _, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssert(true)
    }

    func testGivenNewGameWhenInitiatedThenCurrentQuestionIsTheFirstOne() throws {
        let sut = Game(questions: Question.mockArray(size: 5))
        
        guard case .running(let currentQuestion, _, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssertEqual(currentQuestion.correctAnswer, "Good Answer 1")
    }

}
