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
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {

    }
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            if let error {
                // TODO: handle error correctly
                print(error)
                return
            }

            print("LOGGED AS: \(GKLocalPlayer.local.alias)")
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
