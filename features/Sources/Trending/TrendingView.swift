import SwiftUI
import ComposableArchitecture

public struct TrendingView: View {
    
    let store: StoreOf<Trending>
    
    public init(store: StoreOf<Trending>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                
                let height = proxy.size.height / 3
                
                ScrollView {
                    VStack {
                        Text("Today")
                        TrendingMoviesView(store: self.store.scope(state: \.trendingMoviesToday, action: { .trendingMoviesToday($0) }))
                            .frame(height: height)
                        
                        Text("This week")
                        TrendingMoviesView(store: self.store.scope(state: \.trendingMoviesThisWeek, action: { .trendingMoviesThisWeek($0) }))
                            .frame(height: height)
                    }
                }
                .navigationTitle("Trending")
            }
        }
    }
}
