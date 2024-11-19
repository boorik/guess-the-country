//
//  RealTimeGame.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 10/18/24.
//
import UIKit

@MainActor
final class RealTimeGame: NSObject, ObservableObject {
    @Published var friends: [Friend] = []
    /// The root view controller of the window.
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
}
