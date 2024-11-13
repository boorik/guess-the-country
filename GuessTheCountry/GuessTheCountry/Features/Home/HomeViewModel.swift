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
class HomeViewModel: NSObject, GKLocalPlayerListener {
    
    private let multiplayerService = MultiplayerService()
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {

    }
    
    func checkForAuthenticationWhenHomeAppears() {
        if !multiplayerService.isAuthenticated() {
            multiplayerService.autenticateUser(manuallyAuthentication: false)
        }
    }
    
    func authenticateUserWithGameCenter() {
        multiplayerService.autenticateUser(manuallyAuthentication: true)
    }
    
    func checkIfAllowedToMuliplayer() -> Bool {
        return multiplayerService.isAuthenticated()
    }
    
    func checkForAuthentication() {
        
    }
    
    func createMultiplayerSession(minPlayer: Int, maxPlayer: Int) throws {

    }
}
