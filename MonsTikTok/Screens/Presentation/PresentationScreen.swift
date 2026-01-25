import SwiftUI

struct PresentationScreen: View {
    @State private var coordinator = PresentationCoordinator()
    
    var body: some View {
        MainTabScreen()
            .environment(\.presentationCoordinator, coordinator)
    }
}
