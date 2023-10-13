import ComposableArchitecture
import TMDBCore

public struct MoviesByGenre: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        
        public init() {}
        
        var genreList = GenreList.State()
        var movies = MovieList.State()
    }
    
    public enum Action: Equatable {
        case movies(MovieList.Action)
        case genreList(GenreList.Action)
    }
    
    public var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
                
            case let .genreList(.delegate(action)):
                switch action {
                case let .genresFetched(id):
                    return state.movies
                        .fetchMoviesByGenre(genreID: id)
                        .map(Action.movies)
                }
                
            case .genreList:
                return .none
                
            case .movies:
                return .none
            }
        }
            
        Scope(state: \.movies, action: /Action.movies) {
            MovieList()
        }
        
        Scope(state: \.genreList, action: /Action.genreList) {
            GenreList()
        }
    }
}

// https://github.com/pointfreeco/swift-composable-architecture/discussions/1952#discussioncomment-5167956
extension MovieList.State {
    
    mutating func fetchMoviesByGenre(genreID: Int) -> Effect<MovieList.Action> {
        
        @Dependency(\.movieClient.movieList) var movieList
        
        return .run { send in
            await send(.response(
                TaskResult {
                    try await movieList(
                        MovieListRequest(
                            type: .discover(
                                .init(genreIDs: [genreID])
                            )
                        )
                    )
                }
            ))
        }
    }
}
