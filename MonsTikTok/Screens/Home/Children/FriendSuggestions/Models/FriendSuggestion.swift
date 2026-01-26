struct FriendSuggestion: Identifiable {
    let id: String
    let avatar: String
    let displayName: String
    let reason: FriendSuggestionReason
    let isFollowingYou: Bool
}

enum FriendSuggestionReason {
    case sharedVideo
    case fromContacts
    case maybeKnow(realName: String)
    
    var text: String {
        switch self {
        case .sharedVideo:
            return "Shared a video with you"
        case .fromContacts:
            return "From your contacts"
        case .maybeKnow(let realName):
            return "You may know \(realName)"
        }
    }
}

extension Array where Element == FriendSuggestion {
    static let demoCase: [FriendSuggestion] = [
        .init(
            id: "1",
            avatar: "https://i.pravatar.cc/150?img=21",
            displayName: "Hoàng Phạm",
            reason: .maybeKnow(realName: "Phạm Đình Hoàng"),
            isFollowingYou: true
        ),
        .init(
            id: "2",
            avatar: "https://i.pravatar.cc/150?img=22",
            displayName: "Minh Trần",
            reason: .fromContacts,
            isFollowingYou: false
        ),
        .init(
            id: "3",
            avatar: "https://i.pravatar.cc/150?img=23",
            displayName: "Linh Nguyen ✨",
            reason: .sharedVideo,
            isFollowingYou: true
        ),
        .init(
            id: "4",
            avatar: "https://i.pravatar.cc/150?img=24",
            displayName: "Khoa Le",
            reason: .maybeKnow(realName: "Lê Minh Khoa"),
            isFollowingYou: false
        ),
        .init(
            id: "5",
            avatar: "https://i.pravatar.cc/150?img=25",
            displayName: "Hana Mori",
            reason: .fromContacts,
            isFollowingYou: false
        ),
        .init(
            id: "6",
            avatar: "https://i.pravatar.cc/150?img=26",
            displayName: "Tuan Anh",
            reason: .sharedVideo,
            isFollowingYou: true
        ),
        .init(
            id: "7",
            avatar: "https://i.pravatar.cc/150?img=27",
            displayName: "Sarah Kim",
            reason: .maybeKnow(realName: "Kim Soo Young"),
            isFollowingYou: true
        ),
        .init(
            id: "8",
            avatar: "https://i.pravatar.cc/150?img=28",
            displayName: "Quang Tran",
            reason: .fromContacts,
            isFollowingYou: false
        ),
        .init(
            id: "9",
            avatar: "https://i.pravatar.cc/150?img=29",
            displayName: "Mai Vu",
            reason: .sharedVideo,
            isFollowingYou: false
        ),
        .init(
            id: "10",
            avatar: "https://i.pravatar.cc/150?img=30",
            displayName: "Alex Chen",
            reason: .maybeKnow(realName: "Chen Wei"),
            isFollowingYou: true
        ),
        .init(
            id: "11",
            avatar: "https://i.pravatar.cc/150?img=31",
            displayName: "Thảo Nguyễn",
            reason: .fromContacts,
            isFollowingYou: false
        ),
        .init(
            id: "12",
            avatar: "https://i.pravatar.cc/150?img=32",
            displayName: "David Park",
            reason: .maybeKnow(realName: "Park Min Joon"),
            isFollowingYou: true
        ),
        .init(
            id: "13",
            avatar: "https://i.pravatar.cc/150?img=33",
            displayName: "Yuki Tanaka",
            reason: .sharedVideo,
            isFollowingYou: false
        ),
        .init(
            id: "14",
            avatar: "https://i.pravatar.cc/150?img=34",
            displayName: "Chris Wong",
            reason: .maybeKnow(realName: "Wong Kai Ho"),
            isFollowingYou: true
        ),
        .init(
            id: "15",
            avatar: "https://i.pravatar.cc/150?img=35",
            displayName: "Nam Pham",
            reason: .fromContacts,
            isFollowingYou: false
        )
    ]
}
