import SwiftUI

struct NavigationScreen: View {
    @State private var coordinator = NavigationCoordinator()
    @State private var state = NavigationState()
    
    var body: some View {
        NavigationStack(path: $coordinator.routes) {
            MainTabScreen()
        }
        .environment(\.navigationCoordinator, coordinator)
    }
}
