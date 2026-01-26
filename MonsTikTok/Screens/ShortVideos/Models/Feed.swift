struct Feed {
    let id: String
    let url: String
    let title: String
    let description: String
    let isLiked: Bool
    let heartsCount: Int
    let commentsCount: Int
    let isSaved: Bool
    let savedCount: Int
    let sharesCount: Int
    let authorInfo: Author
}

struct Author {
    let id: String
    let avatar: String
    let name: String
    let isFollowing: Bool
}

extension Array where Element == Feed {
    static let demoCase: Self = [
        Feed(
            id: "feed_001",
            url: "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
            title: "A day in the forest 🌲",
            description: "Relaxing moment with nature and sunshine.",
            isLiked: true,
            heartsCount: 128_400,
            commentsCount: 2_341,
            isSaved: false,
            savedCount: 8_912,
            sharesCount: 1_204,
            authorInfo: Author(
                id: "author_001",
                avatar: "https://i.pravatar.cc/150?img=1",
                name: "Alex Green",
                isFollowing: false
            )
        ),
        Feed(
            id: "feed_002",
            url: "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
            title: "Morning routine ☀️",
            description: "Simple habits that changed my life.",
            isLiked: false,
            heartsCount: 89_230,
            commentsCount: 1_532,
            isSaved: false,
            savedCount: 6_104,
            sharesCount: 932,
            authorInfo: Author(
                id: "author_002",
                avatar: "https://i.pravatar.cc/150?img=2",
                name: "Lily Tran",
                isFollowing: true
            )
        ),
        Feed(
            id: "feed_003",
            url: "https://storage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
            title: "Coding at night 💻",
            description: "SwiftUI + AVPlayer + coffee ☕️",
            isLiked: true,
            heartsCount: 245_910,
            commentsCount: 4_876,
            isSaved: false,
            savedCount: 12_445,
            sharesCount: 3_201,
            authorInfo: Author(
                id: "author_003",
                avatar: "https://i.pravatar.cc/150?img=3",
                name: "Nam Pham",
                isFollowing: true
            )
        ),
        Feed(
            id: "feed_004",
            url: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            title: "Street food tour 🍜",
            description: "Best night food spots you must try!",
            isLiked: true,
            heartsCount: 502_331,
            commentsCount: 9_342,
            isSaved: true,
            savedCount: 25_900,
            sharesCount: 7_821,
            authorInfo: Author(
                id: "author_004",
                avatar: "https://i.pravatar.cc/150?img=4",
                name: "Foodie Max",
                isFollowing: true
            )
        ),
        Feed(
            id: "feed_005",
            url: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
            title: "Travel throwback ✈️",
            description: "Missing this beautiful place already.",
            isLiked: true,
            heartsCount: 1_204_882,
            commentsCount: 18_223,
            isSaved: true,
            savedCount: 54_110,
            sharesCount: 14_002,
            authorInfo: Author(
                id: "author_005",
                avatar: "https://i.pravatar.cc/150?img=5",
                name: "Sophia Lee",
                isFollowing: false
            )
        )
    ]
}
