import SwiftUI

struct HomeSelectableView<Items, Content>: View
where Items: RandomAccessCollection, Items.Element: Hashable, Content: View {
    @Namespace private var indicatorNamespace
    
    let items: Items
    @Binding var selected: Items.Element
    let foregroundColor: Color
    @ViewBuilder let content: (Items.Element, _ isSelected: Bool) -> Content
    
    @State private var scrollOffset: CGFloat = 0
    @State private var contentWidth: CGFloat = 1
    @State private var containerWidth: CGFloat = 1
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(items, id: \.self) { item in
                        Button {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                selected = item
                                proxy.scrollTo(item, anchor: .center)
                            }
                        } label: {
                            VStack(spacing: 8) {
                                let isSelected = selected == item
                                
                                content(item, isSelected)
                                    .foregroundStyle(
                                        isSelected ? foregroundColor : foregroundColor.opacity(0.6)
                                    )
                                
                                if selected == item {
                                    Capsule()
                                        .fill(foregroundColor)
                                        .frame(height: 3)
                                        .matchedGeometryEffect(id: "indicator", in: indicatorNamespace)
                                        .shadow(color: .white, radius: 5, x: 0, y: -1)
                                } else {
                                    Color.clear.frame(height: 3)
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        .id(item)
                    }
                }
                .background(contentWidthReader)
                .background(scrollOffsetReader)
            }
            .coordinateSpace(name: "SCROLL")
            .background(containerWidthReader)
            .mask(edgeFadeMask)
            .onAppear {
                proxy.scrollTo(selected, anchor: .center)
            }
        }
    }
    
    private var edgeFadeMask: some View {
        let maxOffset = max(contentWidth - containerWidth, 1)
        let atLeftEdge = scrollOffset <= 1
        let atRightEdge = scrollOffset >= maxOffset - 1
        
        return LinearGradient(
            gradient: Gradient(stops: [
                .init(color: atLeftEdge ? .white : .clear, location: 0.0),
                .init(color: .white, location: 0.10),
                .init(color: .white, location: 0.90),
                .init(color: atRightEdge ? .white : .clear, location: 1.0)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    private var scrollOffsetReader: some View {
        GeometryReader { geo in
            Color.clear.preference(
                key: ScrollOffsetKey.self,
                value: -geo.frame(in: .named("SCROLL")).minX
            )
        }
        .onPreferenceChange(ScrollOffsetKey.self) { value in
            scrollOffset = value
        }
    }
    
    private var contentWidthReader: some View {
        GeometryReader { geo in
            Color.clear
                .onAppear { contentWidth = geo.size.width }
                .onChange(of: geo.size.width) { old, new in contentWidth = new }
        }
    }
    
    private var containerWidthReader: some View {
        GeometryReader { geo in
            Color.clear
                .onAppear { containerWidth = geo.size.width }
                .onChange(of: geo.size.width) { old, new in containerWidth = new }
        }
    }
}

private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#if DEBUG
#Preview {
    @Previewable @State var selection = "For you"
    let items: [String] = ["Ho Chi Minh", "Explore", "Friends", "Following", "For you"]
    HomeSelectableView(
        items: items,
        selected: $selection,
        foregroundColor: .white
    ) { item, isSelected in
            Text(item)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
}
#endif
