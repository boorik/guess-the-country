//
//  GameTests.swift
//  GuessTheCountryTests
//
//  Created by ippon on 19/01/2024.
//

import XCTest

@testable import GuessTheCountry
final class GameTests: XCTestCase {

    func testGivenNewGameWhenInitiatedThenStateIsRunning() throws {
        let sut = Game(questions: Question.mockArray(size: 5))
        
        guard case .running(_, _, _, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssert(true)
    }

    func testGivenNewGameWhenInitiatedThenCurrentQuestionIsTheFirstOne() throws {
        let sut = Game(questions: Question.mockArray(size: 5))
        
        guard case .running(let currentQuestion, _, _, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssertEqual(currentQuestion.correctAnswer, "Good Answer 1")
    }
    
    func testGivenNewGameWhenInitiatedThenOneHintMustBeRevealed() throws {
        let sut = Game(questions: Question.mockArray(size: 5))
        
        guard case .running(_, _, let hints, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssertEqual(hints.count, 1)
    }
    
    func testGivenRunningGameWhenRequestingMoreHintThenOneMoreHintMustBeRevealed() throws {
        let sut = Game(questions: Question.mockArray(size: 5))
        
        let state = sut.revealMoreHints()
        
        guard case .running(_, _, let returnedHints, _) = state else {
            return XCTFail("Game is not running")
        }
        
        XCTAssertEqual(returnedHints.count, 2)
        
        guard case .running(_, _, let internalHints, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        
        XCTAssertEqual(internalHints.count, 2)
    }
    
    func testGivenAllHintAlreadyRevealedWhenRequestingMoreHintThenNoMoreHintShouldBeRevealed() throws {
        let hintNumber = 4
        let questions = Question.mockArray(size: 5, hintsNumber: hintNumber)
        XCTAssertEqual(questions.first?.hints.count, hintNumber)

        let sut = Game(questions: questions)
        
        _ = sut.revealMoreHints()
        let state = sut.revealMoreHints()
        
        guard case .running(_, _, let returnedHints, _) = state else {
            return XCTFail("Game is not running")
        }
        
        XCTAssertEqual(returnedHints.count, 3)
        
        _ = sut.revealMoreHints()
        _ = sut.revealMoreHints()
        
        guard case .running(_, _, let internalHints, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        
        XCTAssertEqual(internalHints.count, 4)
    }
    
    func testGivenNewGameWhenSelectingAWrongAnswerThenTheScoreIsNotUpdatedAndTheNextQuestionIsGiven() throws {
        let sut = Game(questions: Question.mockArray(size: 5))
        
        _ = sut.selectAnswer(answer: "")
        
        guard case let .running(currentQuestion, score, hints, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssertEqual(hints.count, 1)
        XCTAssertEqual(score, 0)
        XCTAssertEqual(currentQuestion.correctAnswer, "Good Answer 2")
    }
    
    func testGivenNewGameWhenSelectingAGoodAnswerThenTheScoreIsUpdatedAndTheNextQuestionIsGiven() throws {
        let sut = Game(questions: Question.mockArray(size: 5))
        
        _ = sut.selectAnswer(answer: "Good Answer 1")
        
        guard case let .running(currentQuestion, score, hints, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssertEqual(hints.count, 1)
        XCTAssertEqual(score, 1)
        XCTAssertEqual(currentQuestion.correctAnswer, "Good Answer 2")
    }
    
    func testGivenTheLastQuestionWhenSelectingAnAnswerThenTheScoreIsUpdatedAndTheGameIsFinished() throws {
        let sut = Game(questions: Question.mockArray(size: 1))
        
        let state = sut.selectAnswer(answer: "Good Answer 1")
        
        guard case let .finished(score: score) = sut.state else {
            return XCTFail("Game should be finished")
        }
        
        XCTAssertEqual(score, 1)
        
        guard case let .finished(score: score) = state else {
            return XCTFail("Game should be finished")
        }
        
        XCTAssertEqual(score, 1)
    }
    
    func testGivenGameIsRunningWhenSelectingAnswerThenHintIsUpdated() throws {
        let sut = Game(questions: Question.mockArray(size: 2))
        
        guard case let .running(_, _, hints, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        let oldFirstHint = hints.first
        let newState = sut.selectAnswer(answer: "Wrong Answer 1")
        guard case let .running(_, _, newHints, _) = newState else {
            return XCTFail("Game is not running")
        }
        
        XCTAssertNotEqual(oldFirstHint, newHints.first)
    }
    
    func testGivenGame() throws {
        let mockedQuestions = Question.mockArray(size: 2)
        let sut = Game(questions: mockedQuestions)
        
        // TODO Expect
        
        guard case let .running(_, _, _, history) = sut.state else {
            return XCTFail("Game is not running")
        }
        
        XCTAssertEqual(history, [])
        
        let firstState = sut.selectAnswer(answer: "Wrong answer 1")
        
        guard case let .running(_, _, _, historyWithOneAnswer) = sut.state else {
            return XCTFail("Game is not running")
        }
        
        XCTAssertEqual(historyWithOneAnswer.count, 1)
        let firstQuestion = try XCTUnwrap(mockedQuestions.first)
        let expectedHistoryElement = HistoryElement(response: "Wrong answer 1", question: firstQuestion, hintUsed: 1)
        
        XCTAssertEqual(expectedHistoryElement, historyWithOneAnswer.first)
    }
}
