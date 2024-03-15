//
//  PrimaryButton.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 23/02/2024.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    let theme: Theme
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.buttonText)
            .padding(20)
            .foregroundStyle(theme.primaryButtonForegroundColor)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(theme.primaryButtonColor)
            )
    }
}
