import ComposableArchitecture
import TMDBCore

public struct TrendingMovies: Reducer {
    
    @Dependency(\.tmdbClient.movieList) var movieList
    
    public init() {}
    
    public struct State: Equatable {
        
        public init() {}
        
        var movieList: IdentifiedArrayOf<Movie> = []
    }
    
    public enum Action {
        case onTask
        case movieListResponse(TaskResult<[Movie]>)
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onTask:
            let request = MovieListRequest(type: .trending(.day))
            return .run { send in
                await send(.movieListResponse(
                    TaskResult {
                        try await movieList(request)
                    }
                ))
            }
            
        case let .movieListResponse(result):
            switch result {
            case let .success(movieList):
                state.movieList = IdentifiedArray(uniqueElements: movieList)
                return .none
                
            case let .failure(error):
                print(error)
                return .none
            }
        }
    }
}
