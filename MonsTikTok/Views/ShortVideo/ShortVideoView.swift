import SwiftUI
import AVKit

struct ShortVideoView: View {
    @Environment(\.isEnabled) private var isEnabled
    @State private var manager: ShortVideoPlayerManager = .init()
    private let player: AVPlayer?
    private let isActive: Bool
    
    private var isLoaded: Bool {
        guard let player else { return false }
        return player.currentItem?.status == .readyToPlay
    }
    
    init(player: AVPlayer?, isActive: Bool) {
        self.player = player
        self.isActive = isActive
    }

    var body: some View {
        ZStack {
            if let player {
                VideoPlayer(player: player)
                    .disabled(true)
            } else {
                Color.black
            }

            manager.state
                .allowsHitTesting(false)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            manager.togglePlayback(player: player)
        }
        .onDisappear {
            manager.cleanup(player: player)
        }
        .onChange(of: isEnabled) { _, newValue in
            manager.updateActive(player: player, newValue && isActive)
        }
        .onChange(of: player) { oldValue, newValue in
            guard let player = newValue else { return }
            manager.setup(player: player, isActive: isEnabled && isActive)
        }
        .onChange(of: isActive) { _, newValue in
            if newValue, isLoaded {
                manager.state = .playing
            }
        }
    }
}
