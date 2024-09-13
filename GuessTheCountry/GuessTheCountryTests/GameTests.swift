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

        guard case .askingQuestion = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssert(true)
    }

    func testGivenNewGameWhenInitiatedThenCurrentQuestionIsTheFirstOne() throws {
        let sut = Game(questions: Question.mockArray(size: 5))

        guard case .askingQuestion(let currentQuestion, _, _) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssertEqual(currentQuestion.correctAnswer, "Good Answer 1")
    }

    func testGivenNewGameWhenInitiatedThenOneHintMustBeRevealed() throws {
        let sut = Game(questions: Question.mockArray(size: 5))

        guard case .askingQuestion(_, _, let hints) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssertEqual(hints.count, 1)
    }

    func testGivenRunningGameWhenRequestingMoreHintThenOneMoreHintMustBeRevealed() throws {
        let sut = Game(questions: Question.mockArray(size: 5))

        let state = sut.revealMoreHints()

        guard case .askingQuestion(_, _, let returnedHints) = state else {
            return XCTFail("Game is not running")
        }

        XCTAssertEqual(returnedHints.count, 2)

        guard case .askingQuestion(_, _, let internalHints) = sut.state else {
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

        guard case .askingQuestion(_, _, let returnedHints) = state else {
            return XCTFail("Game is not running")
        }

        XCTAssertEqual(returnedHints.count, 3)

        _ = sut.revealMoreHints()
        _ = sut.revealMoreHints()

        guard case .askingQuestion(_, _, let internalHints) = sut.state else {
            return XCTFail("Game is not running")
        }

        XCTAssertEqual(internalHints.count, 4)
    }

    func testGivenNewGameWhenSelectingAWrongAnswerThenTheScoreIsNotUpdated() throws {
        let sut = Game(questions: Question.mockArray(size: 5))

        _ = sut.selectAnswer(answer: "")
        _ = sut.getNextQuestion()

        guard case let .askingQuestion(currentQuestion, score, hints) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssertEqual(hints.count, 1)
        XCTAssertEqual(score, 0)
        XCTAssertEqual(currentQuestion.correctAnswer, "Good Answer 2")
    }

    func testGivenNewGameWhenSelectingAGoodAnswerThenTheScoreIsUpdated() throws {
        let sut = Game(questions: Question.mockArray(size: 5))

        _ = sut.selectAnswer(answer: "Good Answer 1")
        _ = sut.getNextQuestion()

        guard case let .askingQuestion(currentQuestion, score, hints) = sut.state else {
            return XCTFail("Game is not running")
        }
        XCTAssertEqual(hints.count, 1)
        XCTAssertEqual(score, 100)
        XCTAssertEqual(currentQuestion.correctAnswer, "Good Answer 2")
    }

    func testGivenTheLastQuestionWhenSelectingAnAnswerThenTheScoreIsUpdated() throws {
        let sut = Game(questions: Question.mockArray(size: 1))

        let state = sut.selectAnswer(answer: "Good Answer 1")

        guard case let .answer(isCorrect: isCorrect, score: score, history: _) = state else {
            return XCTFail("Game should return the answer")
        }

        XCTAssertEqual(score, 100)
    }

    func testGivenARightAnswerWhenCheckAnswerThenState() throws {
        let sut = Game(questions: Question.mockArray(size: 2))

        let state = sut.selectAnswer(answer: "Good Answer 1")

        guard case let .answer(isCorrect, score, history)  = state else {
            return XCTFail("Game should be finished")
        }

        XCTAssertEqual(isCorrect, true)
        XCTAssertEqual(score, 100)

    }

    func testGivenLastQuestionWhenAskingANewQuestionThenTheGameIsFinished() throws {
        let sut = Game(questions: Question.mockArray(size: 1))

        _ = sut.selectAnswer(answer: "Good Answer 1")
        _ = sut.getNextQuestion()

        guard case let .finished(score: 100) = sut.state else {
            return XCTFail("Game should be finished")
        }
    }
}
