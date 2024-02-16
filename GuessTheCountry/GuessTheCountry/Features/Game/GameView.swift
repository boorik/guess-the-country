//
//  GameView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI


struct GameView: View {
    @StateObject var gameViewModel: GameViewModel
    init(game: Game) {
        _gameViewModel = StateObject(wrappedValue: GameViewModel(game: game)
        )
    }
    var hints: some View {
        VStack{
            Text("Hints")
            ForEach(gameViewModel.displayedHints, id: \.self) { hint in
                Text("\(hint.label): \(hint.value)")
            }
            Button(action: {
                gameViewModel.onNextHint()
            }, label: {
                Text(gameViewModel.canDisplayNextHint ? "Indice suivant": "Vous avez le nombre maximum d'indices disponibles")
            })
            .disabled(!gameViewModel.canDisplayNextHint)
        }
    }
    var body: some View {
        VStack {
            ZStack{
                Text("Quel pays ?")
                    .font(.title2)
                HStack {
                    Spacer()
                    Text("Score: \(gameViewModel.score)")
                        .font(.title3)
                }
            }
            .border(.blue)
            .padding(.horizontal, 20)
            .border(.blue)
            
            Spacer()
            
            hints
                .border(.red)
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(gameViewModel.possibleAnswers, id: \.self) { country in
                    Button {
                        gameViewModel.check(answer: country)
                    } label: {
                        Text(country)
                            .frame(maxWidth:.infinity, minHeight: 90, maxHeight: .infinity)
                    }
                    .border(.cyan)
                }
            }
            .padding()
            .border(.brown)
            // TODO : create an end game screen
            // TODO : param the number of answers for a question
            // TODO : improve UI
        }
    }
}

struct QuestionView: View {
    let question: Question
    var body: some View {
        VStack {
            Text("QUESTION")
            
        }
    }
}

#Preview {
    GameView(game: Game(questions: Question.mockArray(size: 4)))
}