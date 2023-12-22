//
//  SwiftUIView.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//

import SwiftUI

struct HomeView: View {
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
        case .error(let error):
            Text(error.localizedDescription)
                .foregroundStyle(Color.red)
        }
        
        /*ZStack {
            Image("worldmap")
                .opacity(0.2)
        }*/
    }
}

#Preview {
    HomeView()
        .environmentObject(Router())
}
