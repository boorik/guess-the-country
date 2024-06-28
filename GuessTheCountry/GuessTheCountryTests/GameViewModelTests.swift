//
//  GameViewModelTests.swift
//  GuessTheCountryTests
//
//  Created by Dan PEROCHEAU on 09/02/2024.
//

import XCTest

@testable import GuessTheCountry
final class GameViewModelTests: XCTestCase {

    func testGivenNewGameWhenInitiatedThenOneHintIsDisplayed() throws {
        let sut = GameViewModel(game: Game(questions: Question.mockArray(size: 5)), router: Router())
        
        XCTAssertEqual(sut.displayedHints.count, 1)
    }
    
    func testGivenWhenAskingANewQuestionThenFirstHintIsUpdated() throws {
        let sut = GameViewModel(game: Game(questions: Question.mockArray(size: 5)), router: Router())
        
        let oldFirstHint = sut.displayedHints.first
        sut.goToNextQuestion()
                
        XCTAssertNotEqual(sut.displayedHints.first, oldFirstHint)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
