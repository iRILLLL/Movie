import ComposableArchitecture
import Trending
import Home
import User

public enum DeepLink: String {
    case account
}

public struct AppFeature: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        
        var selectedTab: Tab = .home
        var homeTab = Home.State()
        var trendingTab = Trending.State()
        
        @PresentationState var account: Account.State?

        public init() {}
    }
    
    public enum Action: Equatable {
        case selectedTabChanged(Tab)
        case accountButtonTapped
        case closeAccountSheetButtonTapped
        case deepLinkTriggered(DeepLink)
        case homeTab(Home.Action)
        case trendingTab(Trending.Action)
        case account(PresentationAction<Account.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectedTabChanged(tab):
                state.selectedTab = tab
                return .none
                
            case .accountButtonTapped:
                state.account = Account.State()
                return .none
                
            case .closeAccountSheetButtonTapped:
                state.account = nil
                return .none
                
            case let .deepLinkTriggered(deepLink):
                switch deepLink {
                case .account:
                    state.account = Account.State()
                    return .none
                }
                
            case .homeTab:
                return .none
                
            case .trendingTab:
                return .none
                
            case .account:
                return .none
            }
        }
        .ifLet(\.$account, action: /Action.account) {
            Account()
        }
        
        Scope(state: \.homeTab, action: /Action.homeTab) {
            Home()
        }
        
        Scope(state: \.trendingTab, action: /Action.trendingTab) {
            Trending()
        }
    }
}
