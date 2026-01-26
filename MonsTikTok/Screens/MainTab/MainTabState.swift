import Observation
import SwiftUI

@Observable final class MainTabState {
    var selectedTab: MainTab = .home
    var isWhite: Bool = false
}

extension EnvironmentValues {
    @Entry var mainTabState: MainTabState = .init()
}
