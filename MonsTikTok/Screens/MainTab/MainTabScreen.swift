import SwiftUI

struct MainTabScreen: View {
    @State private var viewModel = MainTabViewModel()
    
    var body: some View {
        TabScreen(selection: $viewModel.selectedTab) {
            ShortVideosView()
                .tabTag(MainTab.home)

            ShopScreen()
                .tabTag(MainTab.shop)

            InboxScreen()
                .tabTag(MainTab.inbox)

            ProfileScreen()
                .tabTag(MainTab.profile)
        } tabs: {
            tabView
                .overlay(
                    viewModel.selectedTab.foregroundStyle
                        .opacity(0.2)
                        .frame(height: 1)
                        .opacity(viewModel.selectedTab == .home ? 0 : 1),
                    alignment: .top
                )
        }
        .background(Color(.red))
    }
}

private extension MainTabScreen {
    private var tabView: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(MainTab.allCases, id: \.self) { tab in
                let isSelectedTab = tab == viewModel.selectedTab
                tabViewItem(for: tab, with: isSelectedTab)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(maxHeight: .infinity)
        .foregroundStyle(viewModel.selectedTab.foregroundStyle)
        .background(viewModel.selectedTab.backgroundColor)
        .animation(.bouncy(duration: 0.2), value: viewModel.selectedTab)
    }
    
    @ViewBuilder  func tabViewItem(for tab: MainTab, with isSelectedTab: Bool) -> some View {
        if let selectedImage = tab.selectedImage, let unselectedImage = tab.unselectedImage, let title = tab.title {
            Button {
                viewModel.selectedTab = tab
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
                    .foregroundStyle(viewModel.selectedTab.backgroundColor)
                    .background(viewModel.selectedTab.foregroundStyle)
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
