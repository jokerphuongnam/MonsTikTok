import Observation
import AVFoundation
import SwiftUI

@Observable final class ShortVideosState {
    var seekState: SeekBarState = .idle
    var safeAreaInsets: EdgeInsets = .init()
    
    func scrollProgress(midY: CGFloat, screenMidY: CGFloat, screenHeight: CGFloat) -> CGFloat {
        let distance = abs(midY - screenMidY)
        let normalized = distance / screenHeight
        return min(max(normalized, 0), 1)
    }
    
    func opacity(midY: CGFloat, screenMidY: CGFloat, screenHeight: CGFloat) -> CGFloat {
        let progress = scrollProgress(midY: midY, screenMidY: screenMidY, screenHeight: screenHeight)
        
        let fadeStart: CGFloat = 0.8
        
        guard progress > fadeStart else {
            return 1
        }
        
        let fadeProgress = (progress - fadeStart) / (1 - fadeStart)
        return max(0, 1 - fadeProgress)
    }
}
