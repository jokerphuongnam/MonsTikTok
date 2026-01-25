import Observation
import AVFoundation

@Observable
final class ShortVideoPlayerManager {
    private(set) var state: ShortVideoState = .loading
    
    private var statusObserver: NSKeyValueObservation?
    private var endObserver: NSObjectProtocol?
    
    func updateActive(player: AVPlayer?, _ isActive: Bool) {
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
        player?.pause()
        
        if let endObserver {
            NotificationCenter.default.removeObserver(endObserver)
            self.endObserver = nil
        }
        
        statusObserver?.invalidate()
        statusObserver = nil
    }
    
    func setup(player: AVPlayer?, isActive: Bool) {
        guard let player else { return }
        
        player.actionAtItemEnd = .none
        
        endObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        statusObserver = player.observe(\.status, options: [.new, .initial]) { item, _ in
            DispatchQueue.main.async {
                switch item.status {
                case .readyToPlay:
                    if isActive {
                        player.play()
                    }
                    self.state = .init(isActive: isActive)
                    
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
