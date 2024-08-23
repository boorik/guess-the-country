//
//  HintView.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 23/08/2024.
//
import SwiftUI

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
                    Text("\(hint.value)")
                        .padding(10)
                }
                .padding(10)
            case .number:
                HStack {
                    Text("\(hint.label):")
                    Text(Int(hint.value) ?? 0, format: .number)
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
