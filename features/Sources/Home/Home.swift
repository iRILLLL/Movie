import ComposableArchitecture
import TMDBCore

public struct Home: Reducer {
    
    @Dependency(\.movieClient.genreList) var genreList
    @Dependency(\.movieClient.movieList) var movieList
    
    public init() {}
    
    public struct State: Equatable {
        
        public init() {}
        
        var genreList: IdentifiedArrayOf<Genre> = []
        var movieList: [Genre: IdentifiedArrayOf<Movie>] = [:]
    }
    
    public enum Action: Equatable {
        case onTask
        case genreListResponse(TaskResult<[Genre]>)
        case movieListResponse(Genre, TaskResult<[Movie]>)
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onTask:
            return .run { send in
                await send(.genreListResponse(
                    TaskResult {
                        try await genreList()
                    }
                ))
            }
            
        case let .movieListResponse(genre, result):
            switch result {
            case let .success(movieList):
                state.movieList[genre] = IdentifiedArray(uniqueElements: movieList)
                return .none
                
            case let .failure(error):
                print(error)
                return .none
            }
            
        case let .genreListResponse(result):
            switch result {
            case let .success(genreList):                
                state.genreList = IdentifiedArray(uniqueElements: genreList)
                return .run { send in
                    await withThrowingTaskGroup(of: Void.self) { group in
                        for genre in genreList {
                            let request = MovieListRequest(type: .discover(.init(genreIDs: [genre.id])))
                            group.addTask {
                                await send(.movieListResponse(genre,
                                    TaskResult {
                                        try await movieList(request)
                                    }
                                ))
                            }
                        }
                    }
                }
                
            case let .failure(error):
                print(error)
                return .none
            }
        }
    }
}
