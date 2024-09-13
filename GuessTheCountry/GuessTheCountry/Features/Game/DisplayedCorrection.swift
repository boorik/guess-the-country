//
//  DisplayedCorrection.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 23/08/2024.
//

import Foundation
import MapKit
struct DisplayedCorrection: Identifiable {
    let id = UUID()
    let location: CLLocationCoordinate2D
    let isCorrect: Bool
    let message: String
    let goodAnswer: String
    let givenAnswer: String
}

extension DisplayedCorrection {
    static var mock: DisplayedCorrection {
        DisplayedCorrection(
            location: .london,
            isCorrect: true,
            message: "Bonne réponse",
            goodAnswer: "42",
            givenAnswer: "42"
        )
    }
}
extension CLLocationCoordinate2D {
    static var london: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
    }
}

extension MKCoordinateRegion {
    static var london: MKCoordinateRegion {
        MKCoordinateRegion(center: .london, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }
}
