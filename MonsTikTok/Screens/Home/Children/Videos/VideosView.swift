import SwiftUI

struct VideosView: View {
    @State private var viewModel = VideosViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: .init(
                    repeating: .init(
                        .flexible(),
                        spacing: 16,
                        alignment: .center
                    ),
                    count: 2
                ),
                alignment: .center,
                spacing: 16
            ) {
                ForEach(viewModel.videos, id: \.id) { video in
                    videoItem(video)
                }
            }
            .padding(16)
        }
        .background(.white)
        .refreshable {
            await viewModel.refreshFeed()
        }
    }
}

private extension VideosView {
    func videoItem(_ video: DiscoverVideo) -> some View {
        VStack(spacing: 8) {
            NetworkImage.networkImage(video.thumbnail)
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(16)
            
            Text(video.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black)
                .lineLimit(1)
            
            HStack(spacing: 4) {
                NetworkImage.networkImage(video.authorInfo.avatar)
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .clipShape(.circle)
                
                Text(video.authorInfo.name)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(.heart.fill(video.liked))
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(video.liked ? .pink : .black)
                    .frame(width: 16, height: 16)
                
                Text(video.heartCount.formattedNumber())
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.black.opacity(0.7))
            }
        }
    }
}
