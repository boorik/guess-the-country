//
//  Theme.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 23/02/2024.
//

import Foundation
import SwiftUI

struct Theme {
    let backgroundColor: Color
    let answerButtonColor: Color
    let primaryButtonColor: Color
    let primaryForegroundButtonColor: Color
}

extension Theme {
    static var `default` = {
        Theme(
            backgroundColor: Color(.primaryBackground),
            answerButtonColor: Color(.answerButton),
            primaryButtonColor: Color(.primaryButton),
            primaryForegroundButtonColor: Color(.primaryForegroundButton)
        )
    } ()
}
