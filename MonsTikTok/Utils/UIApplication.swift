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

extension UIApplication {
    static var navigationBarHeight: CGFloat {
        let scene = shared.connectedScenes.first as? UIWindowScene
        let window = scene?.windows.first
        let navController = window?.rootViewController as? UINavigationController
        
        let navBarHeight = navController?.navigationBar.frame.height ?? 0
        let statusBarHeight = window?.safeAreaInsets.top ?? 0
        
        return navBarHeight + statusBarHeight
    }
}
