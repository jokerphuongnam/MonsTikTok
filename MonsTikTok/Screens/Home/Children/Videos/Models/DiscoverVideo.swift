struct DiscoverVideo {
    let id: String
    let thumbnail: String
    let title: String
    let liked: Bool
    let heartCount: Int
    let authorInfo: Author
}

extension Array where Element == DiscoverVideo {
    static let demoCase: Self = [
        .init(
            id: "1",
            thumbnail: "https://picsum.photos/360/640?1",
            title: "Sunset vibes in the city 🌇",
            liked: true,
            heartCount: 1_280,
            authorInfo: .init(
                id: "a1",
                avatar: "https://i.pravatar.cc/150?img=1",
                name: "Luna Tran",
                isFollowing: true
            )
        ),
        .init(
            id: "2",
            thumbnail: "https://picsum.photos/360/640?2",
            title: "POV: Coffee hits different ☕️",
            liked: false,
            heartCount: 842,
            authorInfo: .init(
                id: "a2",
                avatar: "https://i.pravatar.cc/150?img=2",
                name: "Minh Nguyen",
                isFollowing: false
            )
        ),
        .init(
            id: "3",
            thumbnail: "https://picsum.photos/360/640?3",
            title: "Night street photography 📸",
            liked: true,
            heartCount: 2_340,
            authorInfo: .init(
                id: "a3",
                avatar: "https://i.pravatar.cc/150?img=3",
                name: "Khoa Le",
                isFollowing: true
            )
        ),
        .init(
            id: "4",
            thumbnail: "https://picsum.photos/360/640?4",
            title: "Travel diary — Japan 🇯🇵",
            liked: false,
            heartCount: 1_590,
            authorInfo: .init(
                id: "a4",
                avatar: "https://i.pravatar.cc/150?img=4",
                name: "Hana Mori",
                isFollowing: false
            )
        ),
        .init(
            id: "5",
            thumbnail: "https://picsum.photos/360/640?5",
            title: "Late night coding session 💻",
            liked: true,
            heartCount: 3_210,
            authorInfo: .init(
                id: "a5",
                avatar: "https://i.pravatar.cc/150?img=5",
                name: "Nam Pham",
                isFollowing: true
            )
        ),
        .init(
            id: "6",
            thumbnail: "https://picsum.photos/360/640?6",
            title: "Street fashion fit check 👟",
            liked: false,
            heartCount: 670,
            authorInfo: .init(
                id: "a6",
                avatar: "https://i.pravatar.cc/150?img=6",
                name: "Mai Vu",
                isFollowing: false
            )
        ),
        .init(
            id: "7",
            thumbnail: "https://picsum.photos/360/640?7",
            title: "Morning routine that works ✨",
            liked: true,
            heartCount: 1_890,
            authorInfo: .init(
                id: "a7",
                avatar: "https://i.pravatar.cc/150?img=7",
                name: "Tuan Anh",
                isFollowing: true
            )
        ),
        .init(
            id: "8",
            thumbnail: "https://picsum.photos/360/640?8",
            title: "Chill beats to study 🎧",
            liked: false,
            heartCount: 930,
            authorInfo: .init(
                id: "a8",
                avatar: "https://i.pravatar.cc/150?img=8",
                name: "Sarah Kim",
                isFollowing: false
            )
        ),
        .init(
            id: "9",
            thumbnail: "https://picsum.photos/360/640?9",
            title: "Minimal desk setup 🖥",
            liked: true,
            heartCount: 2_760,
            authorInfo: .init(
                id: "a9",
                avatar: "https://i.pravatar.cc/150?img=9",
                name: "Quang Tran",
                isFollowing: true
            )
        ),
        .init(
            id: "10",
            thumbnail: "https://picsum.photos/360/640?10",
            title: "Skincare routine for glowing ✨",
            liked: false,
            heartCount: 1_105,
            authorInfo: .init(
                id: "a10",
                avatar: "https://i.pravatar.cc/150?img=10",
                name: "Linh Pham",
                isFollowing: false
            )
        ),
        .init(
            id: "11",
            thumbnail: "https://picsum.photos/360/640?11",
            title: "City lights timelapse 🌃",
            liked: true,
            heartCount: 3_488,
            authorInfo: .init(
                id: "a11",
                avatar: "https://i.pravatar.cc/150?img=11",
                name: "David Park",
                isFollowing: true
            )
        ),
        .init(
            id: "12",
            thumbnail: "https://picsum.photos/360/640?12",
            title: "Hidden cafés in Saigon ☕️",
            liked: false,
            heartCount: 721,
            authorInfo: .init(
                id: "a12",
                avatar: "https://i.pravatar.cc/150?img=12",
                name: "Thao Nguyen",
                isFollowing: false
            )
        ),
        .init(
            id: "13",
            thumbnail: "https://picsum.photos/360/640?13",
            title: "Workout motivation 💪",
            liked: true,
            heartCount: 2_540,
            authorInfo: .init(
                id: "a13",
                avatar: "https://i.pravatar.cc/150?img=13",
                name: "Alex Chen",
                isFollowing: true
            )
        ),
        .init(
            id: "14",
            thumbnail: "https://picsum.photos/360/640?14",
            title: "Cozy rainy day vibes 🌧",
            liked: false,
            heartCount: 880,
            authorInfo: .init(
                id: "a14",
                avatar: "https://i.pravatar.cc/150?img=14",
                name: "Yuki Tanaka",
                isFollowing: false
            )
        ),
        .init(
            id: "15",
            thumbnail: "https://picsum.photos/360/640?15",
            title: "Aesthetic room tour 🛏",
            liked: true,
            heartCount: 4_120,
            authorInfo: .init(
                id: "a15",
                avatar: "https://i.pravatar.cc/150?img=15",
                name: "Chris Wong",
                isFollowing: true
            )
        )
    ]
}
