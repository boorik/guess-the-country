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
    var isMultiplayerButtonActive = false
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {

    }
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [weak self] vc, error in
            if let error {
                // TODO: handle error correctly
                print(error)
                return
            }
            guard let self else { return }

            self.isMultiplayerButtonActive = true
            print("LOGGED AS: \(GKLocalPlayer.local.alias)")
            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
        }
    }
    
    func checkForAuthentication() {
        if !GKLocalPlayer.local.isAuthenticated {
            authenticateUser()
        }
    }
    
    func createMultiplayerSession(minPlayer: Int, maxPlayer: Int) throws {

    }
}
