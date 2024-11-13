//
//  MultiplayerService.swift
//  GuessTheCountry
//
//  Created by ippon on 08/11/2024.
//

import Foundation
import GameKit

@MainActor
class MultiplayerService: NSObject, GKLocalPlayerListener {
    
    func autenticateUser(manuallyAuthentication: Bool) {
        GKLocalPlayer.local.authenticateHandler = { [weak self] vc, error in
            
            if(manuallyAuthentication) {
                print("multiplayerService.autoAutenticationUser - MANUAL AUTHENTICATION")
                vc!.modalPresentationStyle = .fullScreen
                guard vc != nil else { return }
            }
            
            guard let self else { return }
            
            if let error {
                // TODO: handle error correctly
                print(error)
                return
            }
            
            print("multiplayerService.autoAutenticationUser - LOGGED AS: \(GKLocalPlayer.local.alias)")
            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
        }
    }
    
    func isAuthenticated() -> Bool {
        return GKLocalPlayer.local.isAuthenticated
    }
}


