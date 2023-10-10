import SwiftUI
import ComposableArchitecture

public struct GenresView: View {
    
    let store: StoreOf<Genres>
    
    public init(store: StoreOf<Genres>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                List {
                    ForEach(viewStore.genreList.elements) { genre in
                        VStack {
                            Text(genre.name)
                            if let movies = viewStore.movieList[genre]?.elements {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                            let moviesToShow = movies.prefix(2)
                                            ForEach(moviesToShow) { movie in
                                                MovieView(movie: movie)
                                                    .frame(width: proxy.size.width * 0.75, height: 300)
                                            }
                                            if movies.count > 2 {
                                                Button("More movies...") {
                                                    
                                                }
                                            }
                                        
                                    }
                                }
                            }
                            
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .task {
                    await viewStore.send(.onTask).finish()
                }
            }
        }
    }
}
