//
//  MultiplayerService.swift
//  GuessTheCountry
//
//  Created by ippon on 08/11/2024.
//

import Foundation
import GameKit

@MainActor
class MultiplayerService: NSObject, @preconcurrency GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        // Dismiss the view controller.
        gameCenterViewController.dismiss(animated: true)
    }

    func autenticateUser() {
        print("Authentication State: \(GKLocalPlayer.local.isAuthenticated)")
        GKLocalPlayer.local.authenticateHandler = { [weak self] vc, error in
            
            if let error {
                // TODO: handle error correctly
                print(error)
                return
            }
            
            guard let self else { return }
            
            print("multiplayerService.autoAutenticationUser - LOGGED AS: \(GKLocalPlayer.local.alias)")
            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
        }
    }
    
    func isAuthenticated() -> Bool {
        return GKLocalPlayer.local.isAuthenticated
    }
}

extension MultiplayerService: @preconcurrency GKLocalPlayerListener {
    public func player(_ player: GKPlayer, didAccept invite: GKInvite) {
        print("multiplayerService.player - didAcceptInvite")
    }
    
    public func player(_ player: GKPlayer, didRequestMatchWithPlayers players: [GKPlayer]) {
        print("multiplayerService.player - didRequestMatchWithPlayers")
    }
}

