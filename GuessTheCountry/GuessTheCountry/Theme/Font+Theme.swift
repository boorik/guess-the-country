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

import Foundation
import SwiftUI

extension Font {
    static func oswaldRegular(size: CGFloat) -> Font { .custom("Oswald-Regular", size: size) }
    static func oswaldLight(size: CGFloat) -> Font { .custom("Oswald-Regular_Light", size: size) }
    static func permanentMarker(size: CGFloat) -> Font { .custom("PermanentMarker-Regular", size: size) }
    static let mainTitle: Font = .permanentMarker(size: 36)
    static let appTitle: Font = .oswaldRegular(size: 32)
    static let buttonText: Font = .oswaldLight(size: 16)
    static let hintText: Font = .oswaldRegular(size: 24)
}
