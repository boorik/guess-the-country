//
//  GameView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI

class GameViewModel: ObservableObject {
    internal init(currentQuestion: Question, questionGenerator: QuestionGenerator) async throws {
        self.currentQuestion = nil
        self.questionGenerator = questionGenerator
        
        let questions: [Question] = try await questionGenerator.generateQuestions(count: 10)
        game = Game(questions: questions, currentQuestionId: 0)
        game.start(questionCount: 10)
    }
    
    @Published var currentQuestion: Question?
    let questionGenerator: QuestionGenerator
    let game: Game

    func start() {
        //TODO: game.start()
    }
}

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
                            //TODO
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
