enum HomeTab {
    case location
    case explore
    case friends
    case following
    case feed
}

extension HomeTab: CaseIterable { }
extension HomeTab: Equatable { }
extension HomeTab: Hashable { }
extension HomeTab: Sendable { }
