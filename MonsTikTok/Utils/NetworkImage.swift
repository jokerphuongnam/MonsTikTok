import SwiftUI
import Kingfisher

struct NetworkImage {
    static func networkImage(_ url: String) -> KFImage {
        KFImage(URL(string: url))
            .resizable()
            .cacheMemoryOnly(false)
            .fade(duration: 0.35)
            .loadDiskFileSynchronously()
            .cancelOnDisappear(true)
            .retry(maxCount: 2, interval: .seconds(2))
            .memoryCacheExpiration(.seconds(60))
    }
}
