//
//  Router.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 15/12/2023.
//

import Foundation
import SwiftUI

enum Destination: Hashable {
    case home
    case game([Question])
    case matchmaker
    case enGame(Int)
}
final class Router: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to destination: Destination) {
        path.append(destination)
    }

    func back() {
        path.removeLast()
    }
}
