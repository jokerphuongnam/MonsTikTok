import SwiftUI

struct MainTabScreen: View {
    @State private var viewModel = MainTabViewModel()
    @State private var state = MainTabState()
    
    var body: some View {
        TabScreen(selection: $state.selectedTab) {
            HomeScreen()
                .tabTag(MainTab.home)
                .environment(\.mainTabState, state)

            ShopScreen()
                .tabTag(MainTab.shop)

            InboxScreen()
                .tabTag(MainTab.inbox)

            ProfileScreen()
                .tabTag(MainTab.profile)
        } tabs: {
            tabView
                .overlay(
                    state.selectedTab.foregroundStyle
                        .opacity(0.2)
                        .frame(height: 1)
                        .opacity(state.selectedTab == .home ? 0 : 1),
                    alignment: .top
                )
        }
    }
}

private extension MainTabScreen {
    private var tabView: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                let isSelectedTab = tab == state.selectedTab
                tabViewItem(for: tab, with: isSelectedTab)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxHeight: .infinity)
        .foregroundStyle(state.isWhite ? .black : state.selectedTab.foregroundStyle)
        .background(state.isWhite ? .white : state.selectedTab.backgroundColor)
        .animation(.bouncy(duration: 0.2), value: state.selectedTab)
    }
    
    @ViewBuilder  func tabViewItem(for tab: MainTab, with isSelectedTab: Bool) -> some View {
        if let selectedImage = tab.selectedImage, let unselectedImage = tab.unselectedImage, let title = tab.title {
            Button {
                state.selectedTab = tab
            } label: {
                VStack(spacing: 4) {
                    Image(isSelectedTab ? selectedImage : unselectedImage)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(height: 20)
                    
                    Text(title)
                        .font(.system(size: 13, weight: .medium))
                }
            }
            .disabled(isSelectedTab)
        } else {
            Button {
                
            } label: {
                Image(.plus)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(height: 20)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundStyle(state.selectedTab.backgroundColor)
                    .background(state.selectedTab.foregroundStyle)
                    .cornerRadius(4)
            }
        }
    }
}

#if DEBUG
#Preview {
    MainTabScreen()
}
#endif
