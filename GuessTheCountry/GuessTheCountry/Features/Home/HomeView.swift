//
//  SwiftUIView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI

struct HomeView: View {
    let theme = Theme.default
    @State var viewModel = HomeViewModel()
    @EnvironmentObject var router: Router
    func startSoloGame() async throws {
        state = .isProcessing
        let questionGenerator = QuestionGenerator(countryService: RemoteCountryService(session: .shared),
                                                  itemGenerator: RandomUniqueItemArrayGenerator())
        let questions = try await questionGenerator.generateQuestions(count: 10)
        state = .idle
        router.navigate(to: .game(questions))
    }


    
    enum HomeState {
        case idle
        case isProcessing
        case error(error: Error)
    }

    @State var state: HomeState = .idle

    var body: some View {
        ScaffoldView {
            switch state {
            case .idle:
                VStack(spacing: 50) {
                    Text("Guess the country!")
                        .font(.mainTitle)
                    VStack {
                        Button {
                            Task {
                                do {
                                    try await startSoloGame()
                                } catch {
                                    // TODO handle error
                                }
                            }
                        } label: {
                            Text("Solo")
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PrimaryButton(theme: theme))
                        
                        Button {
                            Task {
                                router.navigate(to: .matchmaker)
                            }
                        } label: {
                            Text("Multiplayer")
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PrimaryButton(theme: theme))
                        .disabled(!viewModel.isMultiplayerButtonActive)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(30)
                }

            case .isProcessing:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
                    .foregroundStyle(Color.red)
            }
        }
        .onAppear {
            viewModel.checkForAuthentication()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}
