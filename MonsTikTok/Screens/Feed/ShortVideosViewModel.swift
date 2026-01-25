import Observation
import AVFoundation

@Observable final class ShortVideosViewModel {
    var feedItems: [Feed] = []
    var urls: [URL] {
        feedItems.map { URL(string: $0.url)! }
    }
    
    init() {
        onLoad()
    }
    
    func onLoad() {
        feedItems = .demoCase
    }
    
    func refreshFeed() async {
        try? await Task.sleep(nanoseconds: 2.nanoseconds)
        
        feedItems = .demoCase
    }
}
