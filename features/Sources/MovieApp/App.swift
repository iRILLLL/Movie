import ComposableArchitecture
import Trending
import Home

public struct AppFeature: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
    
        public init() {}
        
        var selectedTab: Tab = .home
        var homeTab = Home.State()
        var trendingTab = Trending.State()
    }
    
    public enum Action: Equatable {
        case selectedTabChanged(Tab)
        case homeTab(Home.Action)
        case trendingTab(Trending.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
                
            case .homeTab:
                return .none
                
            case .trendingTab:
                return .none
            }
        }
        
        Scope(state: \.homeTab, action: /Action.homeTab) {
            Home()
        }
        
        Scope(state: \.trendingTab, action: /Action.trendingTab) {
            Trending()
        }
    }
}
