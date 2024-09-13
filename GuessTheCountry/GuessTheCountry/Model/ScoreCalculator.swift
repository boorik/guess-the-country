//
//  ScoreCalculator.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 13/09/2024.
//
import Foundation

protocol ScoreCalculator {
    func incrementScore(indicesUsedCount: Int) -> Int
}

struct ScoreCalculatorUsingPercentage: ScoreCalculator {
    func incrementScore(indicesUsedCount: Int) -> Int {
        Int(100 / indicesUsedCount)
    }
}
