//
//  Font+Theme.swift
//  GuessTheCountry
//
//  Created by Tifenn FLOCH on 03/11/2023.
//  Checked font names using following
/* for family in UIFont.familyNames.sorted() {
    let names = UIFont.fontNames(forFamilyName: family)
    print("Family: \(family) Font names: \(names)")
 }
 */
/*
 Family: Oswald Font names: ["Oswald-Regular", "Oswald-Regular_ExtraLight", "Oswald-Regular_Light", "Oswald-Regular_Medium", "Oswald-Regular_SemiBold", "Oswald-Regular_Bold"]
 Family: Permanent Marker Font names: ["PermanentMarker-Regular"]
 */
//

import Foundation
import SwiftUI

extension Font {
    static func oswaldRegular(size: CGFloat) -> Font { .custom("Oswald-Regular", size: size) }
    static func permanentMarker(size: CGFloat) -> Font { .custom("PermanentMarker-Regular", size: size) }
    static let mainTitle: Font = .permanentMarker(size: 36)
}
