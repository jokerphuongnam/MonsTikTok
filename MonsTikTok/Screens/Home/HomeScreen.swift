import SwiftUI

struct HomeScreen: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.mainTabState) private var mainTabState
    @State private var viewModel = HomeViewModel()
    @State private var state = HomeState()
    
    var body: some View {
        ZStack(alignment: .top) {
            VideosView()
                .padding(.top, safeAreaInsets.top + 52)
                .selection(state.selectedTab == .location)
            
            VideosView()
                .padding(.top, safeAreaInsets.top + 52)
                .selection(state.selectedTab == .explore)
            
            FriendSuggestionsView()
                .padding(.top, safeAreaInsets.top + 52)
                .selection(state.selectedTab == .friends)
            
            ShortVideosView()
                .selection(state.selectedTab == .following)
            
            ShortVideosView()
                .selection(state.selectedTab == .feed)
            
            tabs
                .padding(.horizontal, 64)
        }
        .background(backgroundColor)
        .onChange(of: state.selectedTab) { _, _ in
            setUpTabBar()
        }
        .onAppear {
            setUpTabBar()
        }
    }
    
    private func setUpTabBar() {
        switch state.selectedTab {
        case .feed, .friends, .following:
            mainTabState.isWhite = false
        case .location, .explore:
            mainTabState.isWhite = true
        }
    }
    
    @ViewBuilder private var backgroundColor: some View {
        switch state.selectedTab {
        case .feed, .following:
                Color.black
        case .friends:
            ZStack {
                Image(.friendSuggestionsBackground)
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFill()
                    .frame(maxHeight: .infinity)
            }
            .clipped()
        case .location, .explore:
                Color.white
        }
    }
}

private extension HomeScreen {
    var tabs: some View {
        HomeSelectableView(
            items: HomeTab.allCases,
            selected: $state.selectedTab,
            foregroundColor: foregroundTabColor
        ) { item, isSelected in
            selectionItem(item, isSelected: isSelected)
        }
        .zIndex(101)
        .offset(y: safeAreaInsets.top)
    }
    
    private var foregroundTabColor: Color {
        switch state.selectedTab {
        case .feed, .friends, .following:
                .white
        case .location, .explore:
                .black
        }
    }
}

private extension HomeScreen {
    func selectionItem(_ tab: HomeTab, isSelected: Bool) -> some View {
        Text(selectionTitle(tab))
            .font(.system(size: 13, weight: .medium))
            .shadow(color: .white, radius: 5, x: 0, y: -1)
    }
    
    func selectionTitle(_ tab: HomeTab) -> String {
        switch tab {
        case .location:
            "Ho Chi Minh"
        case .explore:
            "Explore"
        case .friends:
            "Friends"
        case .following:
            "Following"
        case .feed:
            "For you"
        }
    }
}
