import SwiftUI
import Lottie

struct LoadingView: View {
    var body: some View {
        LottieView(animation: LottieAnimation.named("Loading_Dots_Blue"))
            .looping()
            .scaledToFit()
            .frame(height: 64)
    }
}

#if DEBUG
#Preview {
    LoadingView()
}
#endif
