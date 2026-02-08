struct AppNotification: Identifiable {
    let id: String
    let avatar: String
    let title: String
    let subtitle: String
    let timeAgo: String
    let isUnread: Bool
    let type: NotificationType
}

enum NotificationType {
    case like
    case comment
    case follow
    case live
    case system
    
    var icon: String {
        switch self {
        case .like: return "heart.fill"
        case .comment: return "message.fill"
        case .follow: return "person.badge.plus"
        case .live: return "dot.radiowaves.left.and.right"
        case .system: return "bell.fill"
        }
    }
}

extension Array where Element == AppNotification {
    static let demoNotifications: [AppNotification] = (0..<50).map { index in
        let name = demoNames[index % demoNames.count]
        let avatarIndex = 10 + (index % 30)
        let time = demoTimes[index % demoTimes.count]
        let unread = index < 12   // first 12 unread (realistic)
        
        let type: NotificationType = {
            switch index % 5 {
            case 0: return .like
            case 1: return .comment
            case 2: return .follow
            case 3: return .live
            default: return .system
            }
        }()
        
        switch type {
        case .like:
            return .init(
                id: "\(index)",
                avatar: "https://i.pravatar.cc/150?img=\(avatarIndex)",
                title: "\(name) liked your video",
                subtitle: demoComments[index % demoComments.count],
                timeAgo: time,
                isUnread: unread,
                type: .like
            )
            
        case .comment:
            return .init(
                id: "\(index)",
                avatar: "https://i.pravatar.cc/150?img=\(avatarIndex)",
                title: "\(name) commented on your video",
                subtitle: "“\(demoComments[index % demoComments.count])”",
                timeAgo: time,
                isUnread: unread,
                type: .comment
            )
            
        case .follow:
            return .init(
                id: "\(index)",
                avatar: "https://i.pravatar.cc/150?img=\(avatarIndex)",
                title: "\(name) started following you",
                subtitle: "Follow back?",
                timeAgo: time,
                isUnread: unread,
                type: .follow
            )
            
        case .live:
            return .init(
                id: "\(index)",
                avatar: "https://i.pravatar.cc/150?img=\(avatarIndex)",
                title: "Live now: \(name)",
                subtitle: "Join the live stream",
                timeAgo: time,
                isUnread: unread,
                type: .live
            )
            
        case .system:
            return .init(
                id: "\(index)",
                avatar: "",
                title: "Your video reached \(Int.random(in: 5_000...120_000)) views 🎉",
                subtitle: "Keep going!",
                timeAgo: time,
                isUnread: unread,
                type: .system
            )
        }
    }
}

private extension Array where Element == AppNotification {
    private static let demoNames = [
        "Linh Nguyen", "Hoàng Phạm", "Sarah Kim", "Tuan Anh", "Alex Chen",
        "Mai Vu", "David Park", "Yuki Tanaka", "Chris Wong", "Nam Pham",
        "Thảo Nguyễn", "Minh Trần", "Khoa Le", "Hana Mori", "Quang Tran"
    ]
    
    private static let demoComments = [
        "🔥 This is amazing!",
        "So cool 😍",
        "Love this ❤️",
        "Can’t stop watching 👀",
        "This deserves more views 🚀"
    ]
    
    private static let demoTimes = [
        "Just now", "2m", "5m", "10m", "30m",
        "1h", "3h", "6h", "12h",
        "1d", "2d", "3d"
    ]
}
