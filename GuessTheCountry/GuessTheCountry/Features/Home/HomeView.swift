//
//  SwiftUIView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI

struct HomeView: View {
    func start() {
        // 1. Generate questions
        // 2. Display loader
        // 3. Go to GameView
    }
    var body: some View {
        ZStack {
            Image("worldmap")
                .opacity(0.2)
            VStack(spacing: 50) {
                Text("Guess the country!")
                    .font(.mainTitle)
                Button {
                    start()
                } label: {
                    Text("Start")
                        .foregroundStyle(Color.white)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .background {
                            Capsule()
                        }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
