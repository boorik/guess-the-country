//
//  SwiftUIView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var game = RealTimeGame()
    @State var showFriends = false
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
    @State var showingAlertForMultiplayer: Bool = false

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
                                if(viewModel.checkIfAllowedToMuliplayer()) {
                                    router.navigate(to: .matchmaker)
                                } else {
                                    showingAlertForMultiplayer = true
                                }
                            }
                        } label: {
                            Text("Multiplayer")
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PrimaryButton(theme: theme))
                        .alert("Attention", isPresented: $showingAlertForMultiplayer) {
                            Button("OK") {
                                showingAlertForMultiplayer = false
                            }
                        } message: {
                            Text("Veuillez vous connecter à GameCenter")
                        }

                        Button {
                            Task {
                                await game.accessFriends()
                                showFriends.toggle()
                            }
                        } label: {
                            Text("Show friends")
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(PrimaryButton(theme: theme))
                       
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
        .popover(isPresented: $showFriends) {
            LazyVStack {
                ForEach(game.friends) { friend in
                    HStack {
                        Text(friend.id.uuidString)
                        Text(friend.player.alias)
                    }
                    .padding()
                    .background(
                        Capsule()
                            .fill(Color.gray)
                    )
                }
            }

        }
        .onAppear {
            viewModel.checkForAuthenticationWhenHomeAppears()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}
