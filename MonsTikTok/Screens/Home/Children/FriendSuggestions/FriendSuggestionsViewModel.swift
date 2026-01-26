import Observation

@Observable final class FriendSuggestionsViewModel {
    var friends: [FriendSuggestion] = []
    
    init() {
        onLoad()
    }
    
    func onLoad() {
        friends = .demoCase
    }
    
    func refreshFeed() async {
        try? await Task.sleep(nanoseconds: 2.nanoseconds)
        
        friends = .demoCase
    }
}
