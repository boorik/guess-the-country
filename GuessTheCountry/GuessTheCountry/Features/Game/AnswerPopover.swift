//
//  AnswerPopover.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 05/07/2024.
//

import SwiftUI
import MapKit
struct AnswerPopover: View {
    let answer: DisplayedCorrection
    let onButtonTapped: () -> Void
    let theme = Theme.default
    @State var region: MKCoordinateRegion

    init(answer: DisplayedCorrection, onButtonTapped: @escaping () -> Void) {
        self.answer = answer
        self.onButtonTapped = onButtonTapped
        self.region = MKCoordinateRegion(center: answer.location, span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.25)
            VStack {
                Text("\(answer.message)")
                    .padding()
                // TODO change constructor, show better span on map
                Map(
                    coordinateRegion: $region
                )
                .frame(width: 200, height: 200)
                Button {
                    onButtonTapped()
                } label: {
                    Text("Question suivante")
                        .multilineTextAlignment(.center)
                        .frame(minHeight: 90, maxHeight: 90)
                }
                .buttonStyle(AnswerButton(theme: theme))
            }
            .padding(24)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }
}

#Preview {
    AnswerPopover(answer: DisplayedCorrection.mock, onButtonTapped: {})
}
