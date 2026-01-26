import UIKit

extension UIApplication {
    static var safeAreaInsets: UIEdgeInsets {
        let window = shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        return window?.safeAreaInsets ?? .zero
    }
}
