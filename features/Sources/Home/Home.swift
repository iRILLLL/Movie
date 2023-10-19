import ComposableArchitecture
import TMDBCore

public struct Home: Reducer {
    
    public enum MovieSection {
        case topRated
        case upcoming
        case popular
        case nowPlaying
    }
    
    public init() {}
    
    public struct State: Equatable {
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case view(ViewAction)
        case _internal(InternalAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case onTask
            case browseByGenresButtonTapped
        }
        
        public enum InternalAction: Equatable {
            case movieListResponse(MovieSection, TaskResult<[Movie]>)
        }
        
        public enum DelegateAction: Equatable {
            case browseByGenresButtonTapped
        }
    }
    
    @Dependency(\.movieClient.movieList) var movieList
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                switch action {
                case .onTask:
                    return .run { send in
                        await withTaskGroup(of: Void.self) { group in
                            group.addTask {
                                await getMovieList(
                                    section: .topRated,
                                    send: send
                                )
                            }
                            group.addTask {
                                await getMovieList(
                                    section: .upcoming,
                                    send: send
                                )
                            }
                            group.addTask {
                                await getMovieList(
                                    section: .nowPlaying,
                                    send: send
                                )
                            }
                            group.addTask {
                                await getMovieList(
                                    section: .popular,
                                    send: send
                                )
                            }
                        }
                    }
                    
                case .browseByGenresButtonTapped:
                    return .send(.delegate(.browseByGenresButtonTapped))
                }
                
            case let ._internal(action):
                switch action {
                case let .movieListResponse(section, result):
                    switch result {
                    case let .success(movies):
                        print(movies)
                        return .none
                        
                    case let .failure(error):
                        print(error)
                        return .none
                    }
                }
                
            case .delegate:
                return .none
            }
        }
    }
}

// MARK: - Private
private extension Home {
    
    func getMovieList(
        section: MovieSection,
        send: Send<Action>
    ) async {
        switch section {
        case .topRated:
            await send(._internal(.movieListResponse(
                section,
                TaskResult {
                    try await movieList(MovieListRequest(type: .topRated))
                }
            )))
            
        case .upcoming:
            await send(._internal(.movieListResponse(
                section,
                TaskResult {
                    try await movieList(MovieListRequest(type: .upcoming))
                }
            )))
            
        case .popular:
            await send(._internal(.movieListResponse(
                section,
                TaskResult {
                    try await movieList(MovieListRequest(type: .popular))
                }
            )))
            
        case .nowPlaying:
            await send(._internal(.movieListResponse(
                section,
                TaskResult {
                    try await movieList(MovieListRequest(type: .nowPlaying))
                }
            )))
            
        }
    }
}
