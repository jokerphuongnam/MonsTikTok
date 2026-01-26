import Observation

@Observable final class VideosViewModel {
    var videos: [DiscoverVideo] = []
    
    init() {
        onLoad()
    }
    
    func onLoad() {
        videos = .demoCase
    }
    
    func refreshFeed() async {
        try? await Task.sleep(nanoseconds: 2.nanoseconds)
        
        videos = .demoCase
    }
}
