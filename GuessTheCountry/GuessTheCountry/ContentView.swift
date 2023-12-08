//
//  ContentView.swift
//  GuessTheCountry
//
//  Created by Yannick JACQUELINE on 13/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var router = NavigationPath()
    var body: some View {
        NavigationStack(path: $router) {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
