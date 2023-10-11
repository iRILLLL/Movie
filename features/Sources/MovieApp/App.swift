import ComposableArchitecture
import Trending
import Home
import User
import Genres
import MovieDetail

public enum DeepLink: String {
    case account
}

public struct AppFeature: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        
        var path = StackState<Path.State>()
        var selectedTab: Tab = .home
        var homeTab = Home.State()
        var trendingTab = Trending.State()
        
        @PresentationState var account: Account.State?

        public init() {}
    }
    
    public enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        case selectedTabChanged(Tab)
        case accountButtonTapped
        case closeAccountSheetButtonTapped
        case deepLinkTriggered(DeepLink)
        case homeTab(Home.Action)
        case trendingTab(Trending.Action)
        case account(PresentationAction<Account.Action>)
    }
    
    public struct Path: Reducer {
        
        public enum State: Equatable {
            case genres(Genres.State)
            case movieDetail(MovieFeature.State)
        }
        
        public enum Action: Equatable {
            case genres(Genres.Action)
            case movieDetail(MovieFeature.Action)
        }
        
        public var body: some ReducerOf<Self> {
            Scope(state: /State.genres, action: /Action.genres) {
                Genres()
            }
            
            Scope(state: /State.movieDetail, action: /Action.movieDetail) {
                MovieFeature()
            }
        }
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
                
            case let .path(action):
                switch action {
                case let .element(id: _, action: .genres(.delegate(action))):
                    switch action {
                    case .movieTapped:
                        state.path.append(.movieDetail(MovieFeature.State()))
                        return .none
                    }
                
                default:
                    return .none
                }
                
            case let .homeTab(.delegate(action)):
                switch action {
                case .browseByGenresButtonTapped:
                    state.path.append(.genres(Genres.State()))
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
        .forEach(\.path, action: /Action.path) {
            Path()
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
