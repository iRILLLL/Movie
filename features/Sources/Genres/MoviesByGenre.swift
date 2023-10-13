import ComposableArchitecture
import TMDBCore

public struct MoviesByGenre: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        
        public init() {}
        
        var genres = GenreList.State()
        var movies = MovieList.State()
    }
    
    public enum Action: Equatable {
        case movies(MovieList.Action)
        case genres(GenreList.Action)
    }
    
    public var body: some ReducerOf<Self> {
        
        Scope(state: \.movies, action: /Action.movies) {
            MovieList()
        }
        
        Scope(state: \.genres, action: /Action.genres) {
            GenreList()
        }
        
        Reduce { state, action in
            switch action {
                
            case let .genres(.delegate(action)):
                switch action {
                case let .genresFetched(id):
                    return state.movies
                        .fetchMoviesByGenre(genreID: id)
                        .map(Action.movies)
                }
                
            case .genres:
                return .none
                
            case .movies:
                return .none
            }
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
