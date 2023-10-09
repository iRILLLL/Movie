import ComposableArchitecture
import Trending
import Home
import User

public struct AppFeature: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
    
        public init() {}
        
        var selectedTab: Tab = .home
        var homeTab = Home.State()
        var trendingTab = Trending.State()
        
        @PresentationState var account: Account.State?
    }
    
    public enum Action: Equatable {
        case selectedTabChanged(Tab)
        case accountToolbarButtonTapped
        case closeAccountSheetToolbarButtonTapped
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
                
            case .accountToolbarButtonTapped:
                state.account = Account.State()
                return .none
                
            case .closeAccountSheetToolbarButtonTapped:
                state.account = nil
                return .none
                
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
