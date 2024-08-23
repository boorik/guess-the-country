//
//  DisplayedHint.swift
//  GuessTheCountry
//
//  Created by vincent blanchet on 23/08/2024.
//

struct DisplayedHint: Hashable, Identifiable {
    var id: String {
        value + label
    }

    let value: String
    let label: String
    let type: DisplayedHintType
}

enum DisplayedHintType {
    case image
    case text
    case number
}

extension DisplayedHintType {
    static func fromModel(_ model: HintType) -> DisplayedHintType {
        return switch model {
        case .image:
                .image
        case .text:
                .text
        case .number:
                .number
        }
    }
}
