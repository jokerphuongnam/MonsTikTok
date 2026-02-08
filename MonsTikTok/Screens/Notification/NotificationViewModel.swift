import Observation

@Observable final class NotificationViewModel {
    var items: [AppNotification] = []
    var isRefreshing: Bool = false
   
    init() {
        onLoad()
    }
    
    func onLoad() {
        items = .demoNotifications
    }
    
    func refreshNotification() async {
        isRefreshing = true
        try? await Task.sleep(nanoseconds: 2.nanoseconds)
        
        items = .demoNotifications
        isRefreshing = false
    }
}
