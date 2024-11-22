//
//  RealTimeGame.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 10/18/24.
//
import UIKit
import GameKit

@MainActor
final class RealTimeGame: NSObject, ObservableObject {
    @Published var friends: [Friend] = []
    /// The root view controller of the window.
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }

    func authenticatePlayer() {
        // Set the authentication handler that GameKit invokes.
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                // If the view controller is non-nil, present it to the player so they can
                // perform some necessary action to complete authentication.
                self.rootViewController?.present(viewController, animated: true) { }
                return
            }
            if let error {
                // If you can’t authenticate the player, disable Game Center features in your game.
                print("Error: \(error.localizedDescription).")
                return
            }

            // A value of nil for viewController indicates successful authentication, and you can access
            // local player properties.

            // Register for real-time invitations from other players.
            GKLocalPlayer.local.register(self)
            }
    }

    func isAuthenticated() -> Bool {
        GKLocalPlayer.local.isAuthenticated
    }
}
