import SwiftUI

extension Image {
    indirect enum SystemImage {
        case house
        case handbag
        case bell
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
        case fill(_ systemImage: Self, isFill: Bool = true)
    }
    
    init(_ systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
}

extension Image.SystemImage {
    var rawValue: String {
        switch self {
        case .fill(let systemImage, let isFill):
            systemImage.rawValue + (isFill ? ".fill" : "")
        case .house:
            "house"
        case .handbag:
            "handbag"
        case .bell:
            "bell"
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
    
    func fill(_ isFill: Bool) -> Self {
        .fill(self, isFill: isFill)
    }
}
