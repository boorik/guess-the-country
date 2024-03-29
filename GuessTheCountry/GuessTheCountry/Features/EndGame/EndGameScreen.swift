//
//  EndGameScreen.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 29/03/2024.
//

import SwiftUI

struct EndGameView: View {
    let theme = Theme.default
    let score: Int
    let router: Router
    var body: some View {
        ScaffoldView {
            VStack(spacing: .zero){
                Text("Game over")
                    .font(.appTitle)
                Text("Score \(score)")
                    .font(.hintText)
                    .padding(.vertical, 30)

                Button(action: {
                    router.navigate(to: .home)
                }, label: {
                    Text("Rejouer ?")
                })
                .buttonStyle(PrimaryButton(theme: theme))
            }
        }
    }
}

#Preview {
    EndGameView(score: 100, router: Router())
}
