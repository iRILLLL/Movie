import SwiftUI
import NukeUI
import ComposableArchitecture

public struct TrendingMoviesView: View {
    
    let store: StoreOf<TrendingMovies>
    
    public init(store: StoreOf<TrendingMovies>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TrendingCarouselView(padding: 16, spacing: 16, items: viewStore.movieList, id: \.id, content: { movie, size in
                LazyImage(url: movie.posterURL) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    } else if let error = state.error {
                        Text(error.localizedDescription)
                    } else {
                        ProgressView()
                    }
                }
            })
            .task {
                await viewStore.send(.onTask).finish()
            }
        }
    }
}
