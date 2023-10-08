import ComposableArchitecture

public struct Trending: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        
        public init() {}
        
        var trendingMoviesToday = TrendingMovies.State(period: .day)
        var trendingMoviesThisWeek = TrendingMovies.State(period: .week)
    }
    
    public enum Action: Equatable {
        case trendingMoviesToday(TrendingMovies.Action)
        case trendingMoviesThisWeek(TrendingMovies.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .trendingMoviesToday:
                return .none
                
            case .trendingMoviesThisWeek:
                return .none
            }
        }
        
        Scope(state: \.trendingMoviesToday, action: /Action.trendingMoviesToday) {
            TrendingMovies()
        }
        
        Scope(state: \.trendingMoviesThisWeek, action: /Action.trendingMoviesThisWeek) {
            TrendingMovies()
        }
    }
}
