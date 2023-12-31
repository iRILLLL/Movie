import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
    
    let store: StoreOf<Home>
    
    public init(store: StoreOf<Home>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Button(action: {
                    viewStore.send(.view(.browseByGenresButtonTapped))
                }, label: {
                    Text("Browse by Genres")
                })
            }
            .task {
                viewStore.send(.view(.onTask))
            }
            .navigationTitle("Home")
        }
    }
}
