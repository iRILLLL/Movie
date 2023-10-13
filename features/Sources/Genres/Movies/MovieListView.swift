import SwiftUI
import ComposableArchitecture

struct MovieListView: View {
    
    let store: StoreOf<MovieList>
    
    init(store: StoreOf<MovieList>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            LazyVStack {
                ForEach(viewStore.items) { item in
                    MovieItemView(movie: item)
                }
            }
        }
    }
}
