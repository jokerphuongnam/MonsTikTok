import SwiftUI
import AVFoundation

struct ShortVideoCell: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Binding var seekState: SeekBarState
    @State private var progress: Double = 0
    
    let feed: Feed
    let player: AVPlayer?
    let isActive: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ShortVideoView(player: player)
                .overlay {
                    if seekState == .loading {
                        ProgressView()
                            .tint(.white)
                    }
                }
            
            VStack {
                Group {
                    switch seekState {
                    case .idle:
                        idleState
                    case .holding, .loading:
                        holdingState
                    }
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.2), value: seekState)
                
                SeekBar(progress: $progress, state: $seekState, player: player, isActive: isActive)
            }
            .padding(.horizontal, 8)
        }
        .onAppear {
            observePlayback()
        }
        .onChange(of: player) { _, newValue in
            guard newValue != nil else { return }
            observePlayback()
        }
        .onChange(of: isEnabled) { _, newValue in
            guard let player else { return }
            if isActive, newValue {
                player.play()
            } else {
                player.pause()
            }
        }
    }
}

private extension ShortVideoCell {
    var idleState: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 4) {
                Text(feed.title)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: true, vertical: true)
                    .lineLimit(1)
                
                Text(feed.description)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.white.opacity(0.8))
                    .fixedSize(horizontal: true, vertical: true)
                    .lineLimit(nil)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                NetworkImage.networkImage(feed.authorInfo.avatar)
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .clipShape(.circle)
                    .overlay(alignment: .bottom) {
                        if !feed.authorInfo.isFollowing {
                            Image(.plus)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .frame(width: 8, height: 8)
                                .frame(width: 16, height: 16)
                                .background(.pink)
                                .clipShape(.circle)
                                .offset(y: 8)
                        }
                    }
                
                shortVideoAction(
                    count: feed.heartsCount,
                    foregroundColor: feed.isLiked ? .pink : .white
                ) {
                    Image(.heart.fill)
                }
                
                shortVideoAction(
                    count: feed.commentsCount,
                    foregroundColor: .white
                ) {
                    Image(.ellipsisBubble.fill)
                }
                
                shortVideoAction(
                    count: feed.savedCount,
                    foregroundColor: feed.isSaved ? .yellow : .white
                ) {
                    Image(.bookmark.fill)
                }
                
                shortVideoAction(
                    count: feed.sharesCount,
                    foregroundColor: .white
                ) {
                    Image(.arrowshapeTurnUpRight.fill)
                }
            }
        }
    }
    
    func shortVideoAction(
        count: Int,
        foregroundColor: Color,
        @ViewBuilder icon: () -> Image
    ) -> some View {
        VStack(spacing: 4) {
            icon()
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(foregroundColor)
            
            Text(count.formattedNumber())
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.white)
        }
    }
}

private extension ShortVideoCell {
    var holdingState: some View {
        HStack(spacing: 16) {
            Text("00")
                .font(.system(size: 20, weight: .medium))
            
            Text("/")
                .font(.system(size: 16, weight: .regular))
            
            Text("11")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white.opacity(0.6))
        }
        .foregroundStyle(.white)
    }
}

private extension ShortVideoCell {
    @MainActor private func observePlayback() {
        guard let player else { return }

        let interval = CMTime(seconds: 0.1, preferredTimescale: 600)

        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            DispatchQueue.main.async {
                guard seekState == .idle, let duration = player.currentItem?.duration.seconds,
                      duration > 0 else { return }
                
                progress = time.seconds / duration
            }
        }
    }
}
