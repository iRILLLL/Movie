import SwiftUI
import ComposableArchitecture
import Home
import Trending
import User
import Genres
import MovieDetail

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
            NavigationStackStore(self.store.scope(state: \.path, action: AppFeature.Action.path)) {
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
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.accountButtonTapped)
                        } label: {
                            Image(systemName: "person.crop.circle")
                        }
                    }
                }
                .sheet(
                    store: store.scope(
                        state: \.$account,
                        action: { .account($0) }
                    )
                ) { store in
                    NavigationStack {
                        AccountView(store: store)
                            .navigationTitle("Account")
                            .toolbar {
                                ToolbarItem {
                                    Button {
                                        viewStore.send(.closeAccountSheetButtonTapped)
                                    } label: {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(Color.black)
                                    }
                                }
                            }
                    }
                }
                .onOpenURL { url in
                    guard
                        let components = URLComponents(string: url.absoluteString),
                        let host = components.host,
                        let deepLink = DeepLink(rawValue: host)
                    else { return }
                    viewStore.send(.deepLinkTriggered(deepLink))
                }
            } destination: { store in
                SwitchStore(store) { state in
                    switch state {
                    case .moviesByGenre:
                        CaseLet(
                            /AppFeature.Path.State.moviesByGenre,
                             action: AppFeature.Path.Action.moviesByGenre,
                             then: MoviesByGenreView.init(store:)
                        )
                        
                    case .movieDetail:
                        CaseLet(
                            /AppFeature.Path.State.movieDetail,
                             action: AppFeature.Path.Action.movieDetail,
                             then: MovieDetailView.init(store:)
                        )
                    }
                }
            }
        }
    }
}
