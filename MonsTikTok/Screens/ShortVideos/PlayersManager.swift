import Observation
import AVFoundation

@Observable final class PlayersManager {
    private(set) var currentIndex: Int = 0
    private(set) var isSetup: Bool = false
    private var urls: [URL] = []
    
    private var players: [AVPlayer] = []
    private var assets: [AVURLAsset] = []
    
    func configure(urls: [URL], isActive: Bool) {
        self.urls = urls
        
        self.assets = urls.map { url in
            AVURLAsset(url: url)
        }
        
        Task.detached(priority: .background) { @MainActor [weak self] in
            guard let self else { return }
            for asset in self.assets {
                let _ = try? await asset.load(.tracks, .duration, .preferredTransform)
            }
        }
        
        self.players = assets.enumerated().map { element in
            let (index, asset) = element
            let item = AVPlayerItem(asset: asset)
            item.preferredForwardBufferDuration = 2.0
            item.canUseNetworkResourcesForLiveStreamingWhilePaused = true
            
            let player = AVPlayer(playerItem: item)
            player.automaticallyWaitsToMinimizeStalling = false
            if index != 0 {
                player.pause()
            }
            
            return player
        }
        
//        warmNextPlayers(from: 0, isActive: isActive)
//        play(index: 0, isActive: isActive)
        isSetup = true
    }
    
    func play(index: Int, isActive: Bool) {
        guard index >= 0, index < players.count, isActive else { return }
        guard index != currentIndex else { return }
        
        let previousIndex = currentIndex
        
        players[previousIndex].pause()
        
        currentIndex = index
        players[index].play()
        
        warmNextPlayers(from: index, isActive: isActive)
    }
    
    private func warmNextPlayers(from index: Int, isActive: Bool) {
        guard isActive else { return }
        let start = index + 1
        let end = min(index + 2, players.count - 1)
        
        guard start <= end else { return }
        
        for i in start...end {
            let player = players[i]
            
            player.pause()
        }
    }
    
    func player(for index: Int) -> AVPlayer? {
        guard index >= 0, index < players.count else { return nil }
        return players[index]
    }
    
    func pauseAll() {
        players.forEach { $0.pause() }
    }
    
    func resumeCurrent(isActive: Bool) {
        guard isActive, currentIndex >= 0, currentIndex < players.count else { return }
        players.forEach { $0.pause() }
        players[currentIndex].play()
    }
}
