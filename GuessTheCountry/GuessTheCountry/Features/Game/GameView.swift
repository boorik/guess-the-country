//
//  GameView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI

struct GameView: View {
    let responses = ["France", "USA"]
    var body: some View {
        VStack {
            ZStack{
                Text("Quel pays ?")
                HStack {
                    Spacer()
                    Text("Score: 5")
                }
            }.padding(.horizontal, 20)
            Spacer()
            VStack{
                Text("indice 1: Population 3 millions d'hab")
                    .italic()
                Text("indice 2: Continent Asie")
                    .italic()
                Text("indice 3: Monnaie $")
                    .italic()
                Button(action: {}, label: {
                    Text("Indice suivant")
                })
            }
            Spacer()
            ScrollView(.horizontal) {
                HStack { // MCQ Choice buttons
                    ForEach(responses, id: \.self) { country in
                        Button {
                            
                        } label: {
                            Text(country)
                        }
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    GameView()
}
