import SwiftUI
import AVKit

struct SeekBar: View {
    @Binding var progress: Double
    @Binding var state: SeekBarState
    
    let player: AVPlayer?
    let isActive: Bool

    var body: some View {
        let isIdling = state == .idle
        let buttonSize: CGFloat = isIdling ? 12: 20
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {
                let seekHeight: CGFloat = isIdling ? 8: 16
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(.white.opacity(0.25))
                        .frame(height: seekHeight)
                        .padding(.bottom, 2)

                    Rectangle()
                        .fill(.white)
                        .frame(width: geo.size.width * progress, height: seekHeight)
                        .padding(.bottom, 2)
                }
                .clipShape(.capsule)

                let shape = isIdling ? AnyShape(.circle) : AnyShape(.capsule)
                
                shape
                    .fill(.white)
                    .frame(width: 16, height: buttonSize)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: -1)
                    .offset(x: geo.size.width * progress - 7)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if isActive {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        state = .holding
                                    }
                                }
                                updateProgress(value, width: geo.size.width)
                            }
                            .onEnded { _ in
                                seekToTime()
                            }
                    )
            }
        }
        .frame(height: buttonSize)
    }

    private func updateProgress(_ value: DragGesture.Value, width: CGFloat) {
        let x = min(max(0, value.location.x), width)
        progress = x / width
    }

    private func seekToTime() {
        guard let player, let duration = player.currentItem?.duration.seconds else { return }
        if isActive {
            state = .loading
        }

        let target = duration * progress
        let time = CMTime(seconds: target, preferredTimescale: 600)

        waitUntilReadyThenSeek(player, to: time)
    }
    
    private func waitUntilReadyThenSeek(_ player: AVPlayer, to time: CMTime) {
        guard let item = player.currentItem else { return }
        player.pause()
        
        if item.status == .readyToPlay {
            player.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) { isFinised in
                if isFinised, isActive {
                    player.play()
                    withAnimation(.easeInOut(duration: 0.2)) {
                        state = .idle
                    }
                }
            }
            return
        }
        
        var observer: NSKeyValueObservation?
        observer = item.observe(\.status, options: [.new]) { item, _ in
            guard item.status == .readyToPlay else { return }
            
            observer?.invalidate()
            observer = nil
            
            player.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) { isFinised in
                if isFinised, isActive {
                    player.play()
                    withAnimation(.easeInOut(duration: 0.2)) {
                        state = .idle
                    }
                }
            }
        }
    }
}
