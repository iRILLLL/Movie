import ComposableArchitecture
import TMDBCore

public struct MovieList: Reducer {
    
    public struct State: Equatable {
        var items: IdentifiedArrayOf<Movie> = []
    }
    
    public enum Action: Equatable {
        case response(TaskResult<[Movie]>)
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .response(result):
            switch result {
            case let .success(items):
                state.items = IdentifiedArray(uniqueElements: items)
                return .none
                
            case let .failure(error):
                print(error)
                return .none
            }
        }
    }
}
