import SwiftUI

extension Image {
    indirect enum SystemImage {
        case house
        case handbag
        case textBubble
        case person
        case plus
        case plusCircle
        case play
        case exclamationmarkTriangle
        case heart
        case ellipsisBubble
        case bookmark
        case arrowshapeTurnUpRight
        case fill(_ systemImage: Self)
    }
    
    init(_ systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
}

extension Image.SystemImage {
    var rawValue: String {
        switch self {
        case .fill(let systemImage):
            systemImage.rawValue + ".fill"
        case .house:
            "house"
        case .handbag:
            "handbag"
        case .textBubble:
            "text.bubble"
        case .person:
            "person"
        case .plus:
            "plus"
        case .plusCircle:
            "plus.circle"
        case .play:
            "play"
        case .exclamationmarkTriangle:
            "exclamationmark.triangle"
        case .heart:
            "heart"
        case .ellipsisBubble:
            "ellipsis.bubble"
        case .bookmark:
            "bookmark"
        case .arrowshapeTurnUpRight:
            "arrowshape.turn.up.right"
        }
    }
    
    var fill: Self {
        .fill(self)
    }
}
