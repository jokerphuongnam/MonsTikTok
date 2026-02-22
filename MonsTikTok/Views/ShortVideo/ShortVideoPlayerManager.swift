import Observation
import AVFoundation

@Observable final class ShortVideoPlayerManager {
    var state: ShortVideoState = .loading
    private var isActive: Bool = true
    
    private var statusObserver: NSKeyValueObservation?
    private var endObserver: NSObjectProtocol?
    
    func updateActive(player: AVPlayer?, _ isActive: Bool) {
        self.isActive = isActive
        state = .init(isActive: isActive)
        isActive ? player?.play() : player?.pause()
    }
    
    func togglePlayback(player: AVPlayer?) {
        guard let player, !state.hasError else { return }
        
        if player.isPlaying {
            player.pause()
            state = .paused
        } else {
            player.play()
            state = .playing
        }
    }
    
    func cleanup(player: AVPlayer?) {
        self.isActive = isActive
        player?.pause()
        
        if let endObserver {
            NotificationCenter.default.removeObserver(endObserver)
            self.endObserver = nil
        }
        
        statusObserver?.invalidate()
        statusObserver = nil
    }
    
    func setup(player: AVPlayer?, isActive: Bool) {
        guard let player, isActive else { return }
        
        player.actionAtItemEnd = .none
        
        endObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { [weak player] _ in
            guard let player else { return }
            player.seek(to: .zero)
            player.play()
        }
        
        statusObserver = player.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
            guard let self else { return }
            DispatchQueue.main.async { [weak self, weak player] in
                guard let self, let player else { return }
                switch item.status {
                case .readyToPlay:
                    if self.isActive {
                        player.play()
                    }
                    self.state = .init(isActive: self.isActive)
                case .failed:
                    self.state = .failed(
                        error: item.error ?? NSError(domain: "Unknown", code: -1)
                    )
                case .unknown:
                    self.state = .loading
                @unknown default:
                    break
                }
            }
        }
    }
}
