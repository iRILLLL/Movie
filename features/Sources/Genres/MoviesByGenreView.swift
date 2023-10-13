import SwiftUI
import ComposableArchitecture

public struct MoviesByGenreView: View {
    
    let store: StoreOf<MoviesByGenre>
    
    public init(store: StoreOf<MoviesByGenre>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                VStack {
                    GenreListView(store: store.scope(state: { $0.genres }, action: MoviesByGenre.Action.genres))
                        .frame(height: 50)
                    
                    MovieListView(store: store.scope(state: { $0.movies }, action: MoviesByGenre.Action.movies))
                }
                .listStyle(.plain)
            }
        }
    }
}
