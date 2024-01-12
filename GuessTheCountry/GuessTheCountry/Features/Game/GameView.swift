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
                Text("Indice suivant")
            })
        }
    }
    var body: some View {
        VStack {
            ZStack{
                Text("Quel pays ?")
                HStack {
                    Spacer()
                    Text("Score: \(gameViewModel.score)")
                }
            }.padding(.horizontal, 20)
            
            Spacer()
            
            hints
            
            Spacer()
            
            VStack(spacing: 20) { // MCQ Choice buttons
                ForEach(gameViewModel.possibleAnswers, id: \.self) { country in
                    Button {
                        gameViewModel.check(answer: country)
                    } label: {
                        Text(country)
                    }
                }
            }.padding()
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
    GameView(game: Game(questions: Question.mockArray(size: 5)))
}
