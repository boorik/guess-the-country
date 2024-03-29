//
//  ScaffoldView.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 29/03/2024.
//

import SwiftUI

struct ScaffoldView<T: View>: View {
    let theme = Theme.default
    let content: T

    init(@ViewBuilder _ content: () -> T) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [theme.backgroundColor, .white], startPoint: .center, endPoint: .bottom)
                .ignoresSafeArea()
            content
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ScaffoldView {
        VStack {
            Text("Hello")
            Text("Scaffold")
        }
    }
}
