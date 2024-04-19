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
        VStack{
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
        ScaffoldView {
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
    GameView(game: Game(questions: Question.mockArray(size: 4)), router: .init())
}

struct HintView: View {
    let hint: DisplayedHint

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.blue)
            switch hint.type {
            case .image:
                AsyncImage(url: URL(string: hint.value)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                } placeholder: {
                    ProgressView()
                }
                .padding(20)
            case .text:
                HStack {
                    Text("\(hint.label):")
                    Text(" \(hint.value)")
                        .padding(10)
                }
                .padding(10)
            }
        }
        .foregroundStyle(.white)
        .font(.hintText)
        .frame(width: UIScreen.main.bounds.width * 0.8)
    }
}
