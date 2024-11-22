//
//  HomeViewModel.swift
//  GuessTheCountry
//
//  Created by ippon on 04/10/2024.
//

import Foundation
import GameKit

@Observable
@MainActor
class HomeViewModel {
    init(realTimeGame: RealTimeGame) {
        self.realTimeGame = realTimeGame
    }
    
    let realTimeGame: RealTimeGame
    
    func checkForAuthenticationWhenHomeAppears() {
        if !realTimeGame.isAuthenticated() {
            realTimeGame.authenticatePlayer()
        }
    }
}
