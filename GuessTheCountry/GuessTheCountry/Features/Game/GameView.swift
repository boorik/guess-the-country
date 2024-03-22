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
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(gameViewModel.displayedHints, id: \.self) { hint in
                            HintView(hint: hint)
                            .id(hint.id)
                        }
                    }
                    .padding(UIScreen.main.bounds.width * 0.1)
                    .scrollTargetLayout()
                }
                .onChange(of: gameViewModel.displayedHints){
                    withAnimation {
                        proxy.scrollTo(gameViewModel.displayedHints.last?.id)
                    }
                }
                .scrollTargetBehavior(.viewAligned(limitBehavior:.automatic))
                .scrollIndicators(.hidden)
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

struct HintView: View {
    let hint: DisplayedHint
    
    var body: some View {
        HStack {
            Text("\(hint.label):")
                .padding(10)
            Text(" \(hint.value)")
                .padding(10)
        }
        .foregroundStyle(.white)
        .font(.hintText)
        .frame(width: UIScreen.main.bounds.width * 0.8)
        //.frame(minHeight: 100)
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                .fill(Color.blue)
        )
    }
}
