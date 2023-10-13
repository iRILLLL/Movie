import SwiftUI
import TMDBCore
import ComposableArchitecture

struct GenreListView: View {
    
    let store: StoreOf<GenreList>
    
    init(store: StoreOf<GenreList>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                HStack {
                    ForEach(viewStore.items) { genre in
                        GenreItemView(genre: genre)
                    }
                }
            }
            .task {
                await viewStore.send(.onTask).finish()
            }
        }
    }
}
