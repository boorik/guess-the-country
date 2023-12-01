//
//  GameView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI

class GameViewModel: ObservableObject {
    internal init(questions: [Question]) {
        self.currentQuestion = nil
        do {
            self.game = try Game(questions: questions)
        } catch {
            // TODO display error message
        }
    }
    
    @Published var currentQuestion: Question?
    var game: Game?
    var score: String {
        guard let scoreValue = game?.score else {
            return "0"
        }
        return "\(scoreValue)"
    }
    var possibleAnswers: [String] {
        guard let answers = game?.currentQuestion.possibleAnswers else {
            return []
        }
        return answers
    }
    
    func check(answer: String) {
        game?.onSelectAnswer(answer: answer)
    }
}

struct GameView: View {
    let gameViewModel = GameViewModel(questions: []) // TODO do question mock
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
            VStack{
                Text("Hints")
                Button(action: {}, label: {
                    Text("Indice suivant")
                })
            }
            Spacer()
            ScrollView(.horizontal) {
                HStack { // MCQ Choice buttons
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
    GameView()
}
