import SwiftUI
import ComposableArchitecture
import Home
import Trending
import User

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
            .toolbar {
                ToolbarItem {
                    Button {
                        viewStore.send(.accountToolbarButtonTapped)
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
                                    viewStore.send(.closeAccountSheetToolbarButtonTapped)
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
        }
    }
}
