import SwiftUI

struct NotificationScreen: View {
    @Environment(\.safeAreaInsets) private var safeArea
    @State private var viewModel = NotificationViewModel()
    
    var body: some View {
        List {
            Spacer()
                .frame(height: safeArea.top)
                .listRowInsets(.init())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            Spacer()
                .frame(height: 52)
                .listRowInsets(.init())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            if viewModel.isRefreshing {
                LoadingView()
                    .frame(maxWidth: .infinity)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            
            Spacer()
                .frame(height: 106 - 52)
                .listRowInsets(.init())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            ForEach(viewModel.items, id: \.id) { item in
                NotificationRow(item: item)
                    .listRowInsets(.init())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .background(.white)
        .navigationTitle("Notifications")
        .toolbarColorScheme(.light, for: .navigationBar)
        .refreshable {
            await viewModel.refreshNotification()
        }
    }
}
