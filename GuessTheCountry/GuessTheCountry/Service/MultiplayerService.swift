//
//  MultiplayerService.swift
//  GuessTheCountry
//
//  Created by ippon on 08/11/2024.
//

import Foundation
import GameKit

class MultiplayerService: NSObject, GKLocalPlayerListener {
    
    func authenticateUser(callback: () -> Void)  {
        GKLocalPlayer.local.authenticateHandler = { [weak self] vc, error in
            if let error {
                // TODO: handle error correctly
                print(error)
                return
            }
            guard let self else { return }

            print("LOGGED AS: \(GKLocalPlayer.local.alias)")
            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
        }
    }
}


