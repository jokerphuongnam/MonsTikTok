import SwiftUI

struct FriendSuggestionsView: View {
    @State private var viewModel = FriendSuggestionsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.friends) { friend in
                friendItem(friend)
                    .listRowInsets(.init())
                    .listRowSpacing(.zero)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .listRowSpacing(16)
        .contentMargins(.top, 16)
        .contentMargins(.bottom, 16)
    }
}

private extension FriendSuggestionsView {
    func friendItem(_ friend: FriendSuggestion) -> some View {
        HStack(spacing: 8) {
            NetworkImage.networkImage(friend.avatar)
                .scaledToFit()
                .frame(width: 64, height: 64)
                .clipShape(.circle)
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(friend.displayName)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white)
                    
                    Text(friend.reason.text)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.white.opacity(0.6))
                }
                
                HStack(spacing: 8) {
                    Button {
                        
                    } label: {
                        Text("Remove")
                            .font(.system(size: 14, weight: .medium))
                            .frame(height: 32)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(.gray.opacity(0.6))
                            .clipShape(.capsule)
                    }
                    
                    Button {
                        
                    } label: {
                        Text(friend.isFollowingYou ? "Follow back": "Follow")
                            .font(.system(size: 14, weight: .medium))
                            .frame(height: 32)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(.pink)
                            .clipShape(.capsule)
                    }
                }
                .foregroundStyle(.white)
            }
        }
        .padding(.horizontal, 16)
    }
}
