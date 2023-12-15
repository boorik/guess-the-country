//
//  GuessTheCountryApp.swift
//  GuessTheCountry
//
//  Created by Yannick JACQUELINE on 13/10/2023.
//

import SwiftUI

@main
struct GuessTheCountryApp: App {
    @StateObject var router = Router()
    var body: some Scene {
        WindowGroup {
            ContentView {
                HomeView()
            }
                .environmentObject(router)
        }
    }
}
