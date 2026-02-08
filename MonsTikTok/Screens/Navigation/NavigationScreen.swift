import SwiftUI

struct NavigationScreen: View {
    @State private var coordinator = NavigationCoordinator()
    @State private var state = NavigationState()
    
    var body: some View {
        NavigationStack(path: $coordinator.routes) {
            MainTabScreen()
        }
        .environment(\.navigationCoordinator, coordinator)
        .environment(\.navigationSafeAreaInsets, state.safeAreaInsets)
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        state.safeAreaInsets = proxy.safeAreaInsets
                    }
                    .onChange(of: proxy.safeAreaInsets) { oldValue, newValue in
                        state.safeAreaInsets = proxy.safeAreaInsets
                    }
            }
        )
    }
}
