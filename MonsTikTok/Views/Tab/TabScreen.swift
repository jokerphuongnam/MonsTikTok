import SwiftUI

struct TabScreen<Selection, Content, Tabs>: View where Selection: Hashable, Content: View, Tabs: View {
    @Binding var selection: Selection
    @ViewBuilder let content: Content
    @ViewBuilder let tabs: Tabs
    
    @State private var tags: [AnyHashable] = []
    @State private var width: CGFloat = 1
    @GestureState private var dragOffset: CGFloat = 0
    
    private var currentIndex: Int {
        if Selection.self == Int.self {
            return selection as! Int
        }
        return tags.firstIndex(of: AnyHashable(selection)) ?? 0
    }
    
    var body: some View {
        let currentIndex = currentIndex
        ZStack {
            GeometryReader { proxy in
                let size = proxy.size
                let insets = proxy.safeAreaInsets
                let scale = UIScreen.current.scale
                let rawCorrection = insets.top * 0.12
                let topCorrection = Int(round(rawCorrection * scale)) / Int(scale)
                Group(subviews: content) { subviews in
                    HStack(spacing: 0) {
                        ForEach(subviews.indices, id: \.self) { index in
                            let isActive = currentIndex == index
                            subviews[index]
                                .frame(width: size.width)
                                .frame(height: size.height + insets.top + CGFloat(topCorrection) + 1)
                                .frame(maxHeight: .infinity)
                                .clipShape(.rect)
                                .disabled(!isActive)
                        }
                    }
                    .offset(x: -CGFloat(currentIndex) * size.width + dragOffset)
                    .animation(.interactiveSpring(), value: selection)
                    .gesture(dragGesture(count: subviews.count))
                    .onPreferenceChange(TabTagKey.self) { tags = $0 }
                    .offset(y: -insets.top)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            tabs.frame(height: 56)
        }
    }
}

extension TabScreen {
    
}

extension TabScreen where Selection == Int {
    init(@ViewBuilder content: @MainActor () -> Content, @ViewBuilder tabs: @MainActor () -> Tabs) {
        _selection = .constant(0)
        self.content = content()
        self.tabs = tabs()
    }
}

extension TabScreen {
    private func dragGesture(count: Int) -> some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation.width
            }
            .onEnded { value in
                guard width > 0 else { return }
                let threshold = width * 0.25
                
                var newIndex = currentIndex
                
                if value.translation.width < -threshold {
                    newIndex = min(currentIndex + 1, count - 1)
                } else if value.translation.width > threshold {
                    newIndex = max(currentIndex - 1, 0)
                }
                
                if tags.indices.contains(newIndex),
                   let newTag = tags[newIndex].base as? Selection {
                    selection = newTag
                }
            }
    }
    
    private var sizeReader: some View {
        GeometryReader { geo in
            Color.clear
                .onAppear { width = geo.size.width }
                .onChange(of: geo.size.width) { _, newValue in width = newValue }
        }
    }
}

extension View {
    func tabTag<T: Hashable>(_ tag: T) -> some View {
        preference(key: TabTagKey.self, value: [AnyHashable(tag)])
    }
}

private struct TabTagKey: PreferenceKey {
    static var defaultValue: [AnyHashable] = []
    
    static func reduce(value: inout [AnyHashable], nextValue: () -> [AnyHashable]) {
        value.append(contentsOf: nextValue())
    }
}
