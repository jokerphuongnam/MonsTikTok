import SwiftUI

struct ShortVideosView: View {
    @State private var currentIndex: Int? = 0
    @State private var playerManager = PlayersManager()
    @State private var viewModel = ShortVideosViewModel()
    @State private var state = ShortVideosState()
    private let global = UIScreen.current.bounds
    
    var body: some View {
        let screenMidY = global.midY
        let screenHeight = global.height - state.safeAreaInsets.top - state.safeAreaInsets.bottom
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(Array(viewModel.feedItems.enumerated()), id: \.offset) { element in
                    let (index, feed) = element
                    let player = playerManager.player(for: index)
                    let isActive = index == playerManager.currentIndex
                    
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .global)
                        let midY = frame.midY
                        
                        let opacity = state.opacity(
                            midY: midY,
                            screenMidY: screenMidY,
                            screenHeight: screenHeight
                        )
                        
                        ShortVideoCell(seekState: $state.seekState, feed: feed, player: player, isActive: isActive)
                            .frame(
                                width: global.width,
                                height: screenHeight
                            )
                            .animation(.linear, value: isActive)
                            .id(index)
                            .opacity(opacity)
                    }
                    .frame(
                        width: global.width,
                        height: screenHeight
                    )
                }
            }
        }
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $currentIndex)
        .background(.black)
        .onAppear {
            Task.detached(name: "Load", priority: .utility) {
                await playerManager.configure(urls: viewModel.urls)
            }
        }
        .onChange(of: currentIndex!) { oldIndex, newIndex in
            guard oldIndex != newIndex, newIndex != playerManager.currentIndex else { return }
            playerManager.play(index: newIndex)
            state.seekState = .idle
        }
        .scrollIndicators(.hidden)
        .refreshable {
            await viewModel.refreshFeed()
        }.onAppear {
            UIRefreshControl.appearance(whenContainedInInstancesOf: [UIScrollView.self]).tintColor = .white
        }
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        state.safeAreaInsets = proxy.safeAreaInsets
                    }
                    .onChange(of: proxy.safeAreaInsets) { _, newValue in
                        state.safeAreaInsets = newValue
                    }
            }
        )
    }
}
