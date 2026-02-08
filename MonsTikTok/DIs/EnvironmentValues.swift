import SwiftUI

extension EnvironmentValues {
    @Entry var navigationCoordinator = NavigationCoordinator()
}

extension EnvironmentValues {
    @Entry var presentationCoordinator: PresentationCoordinator = .init()
}

extension EnvironmentValues {
    @Entry var navigationSafeAreaInsets: EdgeInsets = .init()
}
