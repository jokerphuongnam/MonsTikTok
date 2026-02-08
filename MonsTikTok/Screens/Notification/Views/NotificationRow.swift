import SwiftUI

struct NotificationRow: View {
    let item: AppNotification
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                AsyncImage(url: URL(string: item.avatar)) { image in
                    image.resizable()
                } placeholder: {
                    Circle().fill(.gray.opacity(0.3))
                }
                .frame(width: 46, height: 46)
                .clipShape(Circle())
                
                Image(systemName: item.type.icon)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    .padding(4)
                    .background(.black.opacity(0.7))
                    .clipShape(Circle())
                    .offset(x: 16, y: 16)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 15, weight: .semibold))
                
                Text(item.subtitle)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 6) {
                Text(item.timeAgo)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                
                if item.isUnread {
                    Circle()
                        .fill(.red)
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(item.isUnread ? Color.white.opacity(0.04) : .clear)
    }
}
