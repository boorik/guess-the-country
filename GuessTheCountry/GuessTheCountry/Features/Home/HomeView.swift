//
//  SwiftUIView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI
import GameKit

@Observable
@MainActor
class HomeViewModel {
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            if let error {
                // TODO: handle error correctly
                print(error)
                return
            }

            print("LOGGED AS: \(GKLocalPlayer.local.alias)")

        }
    }
}

struct HomeView: View {
    let theme = Theme.default
    @State var viewModel = HomeViewModel()
    @EnvironmentObject var router: Router
    func start() async throws {
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
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                    .buttonStyle(PrimaryButton(theme: theme))
                }

            case .isProcessing:
                ProgressView()
            case .error(let error):
                Text(error.localizedDescription)
                    .foregroundStyle(Color.red)
            }
        }
        .onAppear {
            if !GKLocalPlayer.local.isAuthenticated {
                viewModel.authenticateUser()
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}
