import Observation
import SwiftUI

@Observable
final class PresentationCoordinator {
    
}

extension EnvironmentValues {
    @Entry var presentationCoordinator: PresentationCoordinator = .init()
}
