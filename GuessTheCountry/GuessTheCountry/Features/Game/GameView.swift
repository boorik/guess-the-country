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
    
    init(game: Game, router: Router) {
        _gameViewModel = StateObject(wrappedValue: GameViewModel(game: game, router: router))
    }
    var hints: some View {
        VStack {
            Text("Indices")
                .font(.appTitle)
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(gameViewModel.displayedHints, id: \.id) { hint in
                            HintView(hint: hint)
                                .id(hint.id)
                        }
                    }
                    .padding(UIScreen.main.bounds.width * 0.1)
                    .scrollTargetLayout()
                }
                .onChange(of: gameViewModel.displayedHints) {
                    withAnimation {
                        proxy.scrollTo(gameViewModel.displayedHints.last?.id)
                    }
                }
                .scrollTargetBehavior(.viewAligned(limitBehavior: .automatic))
                .scrollIndicators(.hidden)
            }
            
            Button(
                action: {
                    gameViewModel.onNextHint()
                },
                label: {
                    Text( gameViewModel.nextHintButtonLabel )
                })
            .buttonStyle(PrimaryButton(theme: theme))
            .disabled(!gameViewModel.canDisplayNextHint)
        }
    }
    var body: some View {
        ZStack {
            ScaffoldView {
                VStack {
                    VStack {
                        HStack {
                            Button {
                                gameViewModel.onBackButtonPressed()
                            } label: {
                                Image(systemName: "arrowshape.backward.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .tint(Color.black)
                            }
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
                                gameViewModel.onSelected(choice: country)
                            } label: {
                                Text(country)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, minHeight: 90, maxHeight: .infinity)
                            }
                            .buttonStyle(AnswerButton(
                                theme: theme,
                                isCorrectAnswer: gameViewModel.isCorrectAnswer(countryName: country),
                                givenAnswer: gameViewModel.answer?.givenAnswer == country
                            ))
                        }
                    }
                    .padding()
                }
            }
            if let answer = gameViewModel.answer {
                AnswerPopover(answer: answer) {
                    gameViewModel.goToNextQuestion()
                }
                .ignoresSafeArea()
                .transition(.slide)
            }
        }.alert(isPresented: $gameViewModel.showLeaveConfirmation) {
            Alert(
                title: Text("Voulez-vous quitter la partie en cours ?"),
                primaryButton: .default(
                    Text("Oui"),
                    action: gameViewModel.onLeaveConfirmationPressed
                ),
                secondaryButton: .cancel(
                    Text("Annuler"),
                    action: {}
                )
            )
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
    GameView(game: Game(questions: Question.mockArray(size: 4)), router: .init())
}
