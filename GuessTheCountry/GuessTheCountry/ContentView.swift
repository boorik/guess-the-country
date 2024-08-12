//
//  ContentView.swift
//  GuessTheCountry
//
//  Created by Yannick JACQUELINE on 13/10/2023.
//

import SwiftUI

struct ContentView<Content: View>: View {
    @EnvironmentObject private var router: Router
    var content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .home:
                        HomeView()
                    case .game(let questions):
                        GameView(game: Game(questions: questions), router: router)
                    case .enGame(let score):
                        EndGameView(score: score, router: router)
                    }
                }
        }
    }
}

#Preview {
    ContentView {
        Text("Hello world")
    }.environmentObject(Router())
}
