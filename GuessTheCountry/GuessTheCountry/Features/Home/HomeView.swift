//
//  SwiftUIView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI

struct HomeView: View {
    func start() async throws {
        state = .isProcessing
        let questionGenerator = QuestionGenerator(countryService: RemoteCountryService(session: .shared))
        let questions = try await questionGenerator.generateQuestions(count: 10)
        state = .ready(questions)
    }

    enum HomeState {
        case idle
        case isProcessing
        case ready([Question])
    }

    @State var state: HomeState = .idle

    var body: some View {
        ZStack {
            Image("worldmap")
                .opacity(0.2)
            switch state {
            case .idle:
                VStack(spacing: 50) {
                    Text("Guess the country!")
                        .font(.mainTitle)
                    Button {
                        Task {
                            do {
                                try await start()

                            } catch {
                                // TODO handle error
                            }
                        }
                    } label: {
                        Text("Start")
                            .foregroundStyle(Color.white)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .background {
                                Capsule()
                            }
                    }

                }
            case .isProcessing:
                ProgressView()
            case .ready(let questions):
                GameView(questions: questions)
            }
        }
    }
}

#Preview {
    HomeView()
}
