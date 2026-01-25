import SwiftUI

enum ShortVideoState {
    case loading
    case paused
    case playing
    case failed(error: Error)
    
    init(isActive: Bool) {
        if isActive {
            self = .playing
        } else {
            self = .paused
        }
    }
}

extension ShortVideoState: Sendable { }
extension ShortVideoState: Equatable {
    static func == (lhs: ShortVideoState, rhs: ShortVideoState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.paused, .paused):
            return true
        case (.playing, .playing):
            return true
        case (.failed(let e1), .failed(let e2)):
            return (e1 as NSError).domain == (e2 as NSError).domain &&
            (e1 as NSError).code == (e2 as NSError).code
            
        default:
            return false
        }
    }
}

extension ShortVideoState: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .loading:
            hasher.combine(0)
        case .paused:
            hasher.combine(1)
        case .playing:
            hasher.combine(2)
        case .failed(let error):
            let nsError = error as NSError
            hasher.combine(3)
            hasher.combine(nsError.domain)
            hasher.combine(nsError.code)
        }
    }
}

extension ShortVideoState {
    var hasError: Bool {
        switch self {
        case .failed:
            true
        default:
            false
        }
    }
}

extension ShortVideoState: View {
    var body: some View {
        switch self {
        case .loading:
            ProgressView()
                .tint(.white)
        case .paused:
            Image(.play.fill)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(.white.opacity(0.4))
                .scaledToFit()
                .frame(width: 48, height: 48)
        case .playing:
            EmptyView()
        case .failed:
            VStack {
                Image(.exclamationmarkTriangle)
                    .resizable()
                    .foregroundStyle(.white.opacity(0.6))
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                
                Text("Failed to load video")
            }
        }
    }
}
