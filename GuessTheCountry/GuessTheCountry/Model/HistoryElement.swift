//
//  HistoryElement.swift
//  GuessTheCountry
//
//  Created by Dylan Le Hir on 03/05/2024.
//

import Foundation

struct HistoryElement: Equatable {
    let response: String
    let question: Question
    let hintUsed: Int
}

