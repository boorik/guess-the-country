//
//  MatchmakerView.swift
//  GuessTheCountry
//
//  Created by ippon on 04/10/2024.
//

import SwiftUI
@preconcurrency import GameKit

enum MultiPlayer: Error {
    case failedToCreateMatchmakerViewController
}

// TODO : check this link https://developer.apple.com/documentation/gamekit/finding_multiple_players_for_a_game
struct MatchmakerView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    typealias UIViewControllerType = GKMatchmakerViewController

    var minPlayer: Int
    var maxPlayer: Int
    
    
    func makeUIViewController(context: Context) -> GKMatchmakerViewController {
        let request = GKMatchRequest()
        request.minPlayers = minPlayer
        request.maxPlayers = maxPlayer
        
        guard let matchmakerViewController = GKMatchmakerViewController(matchRequest: request) else {
            // TODO: handle this shit!
            return GKMatchmakerViewController()
        }
        
        matchmakerViewController.matchmakingMode = .inviteOnly
        matchmakerViewController.delegate = context.coordinator
        matchmakerViewController.matchmakerDelegate = context.coordinator
        return matchmakerViewController
    }
    
    func updateUIViewController(_ uiViewController: GKMatchmakerViewController, context: Context) {
    
        
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator : NSObject, @preconcurrency GKMatchmakerViewControllerDelegate, UINavigationControllerDelegate {
        
        internal init(parent: MatchmakerView) {
            self.parent = parent
        }
        
        func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
            parent.isPresented = false
        }
        
        func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: any Error) {
            
        }
        
        
        
        let parent: MatchmakerView
    }
    
}
