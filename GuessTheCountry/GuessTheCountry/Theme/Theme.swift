//
//  Theme.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 23/02/2024.
//

import Foundation
import SwiftUI

struct Theme {
    let primaryButtonColor: Color
    let primaryForegroundButtonColor: Color
}

extension Theme {
    static var `default` = {
        Theme(
            primaryButtonColor: Color(.primaryButton),
            primaryForegroundButtonColor: Color(.primaryForegroundButton)
        )
    } ()
    static var olympicGames = {
        Theme(
            primaryButtonColor: Color(.primaryButtonOG),
            primaryForegroundButtonColor: Color(.primaryForegroundButtonOG)
        )
    } ()
}
