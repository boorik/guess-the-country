//
//  GameView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI
import UIKit

struct GameView: View {
    let theme = Theme.default
    @StateObject var gameViewModel: GameViewModel
    init(game: Game) {
        _gameViewModel = StateObject(wrappedValue: GameViewModel(game: game)
        )
    }
    var hints: some View {
        VStack{
            Text("Indices")
                .font(.appTitle)
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(gameViewModel.displayedHints, id: \.self) { hint in
                        HStack {
                            Text("\(hint.label):")
                                .padding(10)
                            Text(" \(hint.value)")
                                .padding(10)
                        }
                        .font(.buttonText)
                        .background(
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                                .fill(Color.red)
                        )
                        .frame(maxWidth: UIScreen.main.bounds.width - 20)
                        
                    }
                }
            }
            
            Button(action: {
                gameViewModel.onNextHint()
            }, label: {
                Text(gameViewModel.canDisplayNextHint ? "Indice suivant": "Vous avez le nombre maximum d'indices disponibles")
            })
            .buttonStyle(PrimaryButton(theme: theme))
            .disabled(!gameViewModel.canDisplayNextHint)
        }
    }
    var body: some View {
        ZStack {
            LinearGradient(colors: [theme.backgroundColor, .white], startPoint: .center, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                VStack{
                    HStack {
                        Spacer()
                        Text("Score: \(gameViewModel.score)")
                            .font(.appTitle)
                    }
                    Text("Quel pays ?")
                        .font(.mainTitle)
                    
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                hints
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
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
                        .buttonStyle(AnswerButton(theme: theme))
                    }
                }
                .padding()
            }
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
