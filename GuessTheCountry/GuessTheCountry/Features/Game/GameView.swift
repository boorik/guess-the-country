//
//  GameView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI


struct GameView: View {
    let theme = Theme.olympicGames
    @StateObject var gameViewModel: GameViewModel
    init(game: Game) {
        _gameViewModel = StateObject(wrappedValue: GameViewModel(game: game)
        )
    }
    var hints: some View {
        VStack{
            Text("Indices")
                .font(.title)
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(gameViewModel.displayedHints, id: \.self) { hint in
                        HStack {
                            Text("\(hint.label):")
                                .border(Color.blue)
                                .padding(10)
                                .border(Color.red)
                            Text(" \(hint.value)")
                                .border(Color.blue)
                                .padding(10)
                                .border(Color.red)
                        }
                        .background(
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                                .fill(Color.red)
                        )
                        
                    }
                }
            }
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.red)
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(gameViewModel.possibleAnswers, id: \.self) { country in
                    Button {
                        gameViewModel.check(answer: country)
                    } label: {
                        Text(country)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth:.infinity, minHeight: 90, maxHeight: .infinity)
                    }
                    .buttonStyle(PrimaryButton(theme: theme))
                }
            }
            .padding()
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
