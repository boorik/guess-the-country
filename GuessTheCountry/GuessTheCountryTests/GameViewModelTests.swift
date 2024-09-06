//
//  GameViewModelTests.swift
//  GuessTheCountryTests
//
//  Created by Dan PEROCHEAU on 09/02/2024.
//

import Testing
@testable import GuessTheCountry


struct GameViewModelTests {
    @Test("Given new game when initiated then one hint is displayed")
    func testGivenNewGameWhenInitiatedThenOneHintIsDisplayed() throws {
        let sut = GameViewModel(game: Game(questions: Question.mockArray(size: 5)), router: Router())

        #expect(sut.displayedHints.count == 1)
    }

    @Test("When asking a new question then first hint is updated")
    func firstHintUpdated() throws {
        let sut = GameViewModel(game: Game(questions: Question.mockArray(size: 5)), router: Router())

        let oldFirstHint = sut.displayedHints.first
        sut.goToNextQuestion()

        #expect(sut.displayedHints.first != oldFirstHint)
    }

    @Test("Given answer When correct then Display success")
    func displaySuccess() throws {
        let question = Question(
            hints: [Hint(label: "indice", value: "la tête à ?", type: HintType.text)],
            correctAnswer: "Toto",
            possibleAnswers: [
                "Toto",
                "Tata",
                "Tutu",
                "Réponse D"
            ]
        )
        let sut = GameViewModel(
            game: Game(
                questions: [question]
            ),
            router: Router()
        )

        sut.onSelected(choice: "Toto")
        let answer = try #require(sut.answer)

        #expect(answer.isCorrect)
    }
}
