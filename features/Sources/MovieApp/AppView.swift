import SwiftUI
import ComposableArchitecture
import Home
import Trending

public enum Tab: Equatable {
    case home
    case trending
}

public struct AppView: View {
    
    let store: StoreOf<AppFeature>
    
    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: \.selectedTab) { viewStore in
            TabView(selection: viewStore.binding(send: AppFeature.Action.selectedTabChanged)) {
                
                HomeView(
                    store: self.store.scope(state: \.homeTab, action: AppFeature.Action.homeTab)
                )
                .tabItem { Label("Home", systemImage: "house") }
                .tag(Tab.home)
                
                TrendingView(
                    store: self.store.scope(state: \.trendingTab, action: AppFeature.Action.trendingTab)
                )
                .tabItem { Label("Trending", systemImage: "flame") }
                .tag(Tab.trending)
            }
        }
    }
}
