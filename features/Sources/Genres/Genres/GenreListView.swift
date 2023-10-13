import SwiftUI
import TMDBCore
import ComposableArchitecture

public struct GenreListView: View {
    
    let store: StoreOf<GenreList>
    
    public init(store: StoreOf<GenreList>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView(.horizontal, showsIndicators: false) {
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
