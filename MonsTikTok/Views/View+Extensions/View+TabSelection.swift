import SwiftUI

extension View {
    func selection(_ isSelected: Bool) -> some View {
        self
            .disabled(!isSelected)
            .opacity(isSelected ? 1 : 0)
            .zIndex(isSelected ? 1: 0)
            .allowsHitTesting(isSelected)
    }
}
