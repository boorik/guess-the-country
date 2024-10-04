//
//  MultiplayerView.swift
//  GuessTheCountry
//
//  Created by ippon on 04/10/2024.
//

import SwiftUI

struct MultiplayerView: View {
    // TODO: manage matchmaker dismiss
    @State var showMatchMaker = true
    
    var body: some View {
        Text("MultiplayerView")
            .fullScreenCover(isPresented: $showMatchMaker) {
                MatchmakerView(minPlayer: 2, maxPlayer: 2)
            }
    }
}
