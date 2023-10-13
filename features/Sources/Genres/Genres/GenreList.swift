import ComposableArchitecture
import TMDBCore

public struct GenreList: Reducer {
    
    public struct State: Equatable {
        var items: IdentifiedArrayOf<Genre> = []
    }
    
    public enum Action: Equatable {
        case onTask
        case response(TaskResult<[Genre]>)
        case delegate(DelegateAction)
        
        public enum DelegateAction: Equatable {
            case genresFetched(Int)
        }
    }
    
    @Dependency(\.movieClient.genreList) var genreList
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onTask:
            return .run { send in
                await send(.response(
                    TaskResult {
                        try await genreList()
                    }
                ))
            }
            
        case let .response(result):
            switch result {
            case let .success(items):
                guard let item = items.first else { return .none }
                state.items = IdentifiedArray(uniqueElements: items)
                return .send(.delegate(.genresFetched(item.id)))
                
            case let .failure(error):
                print(error)
                return .none
            }

        case .delegate:
            return .none
        }
    }
}
