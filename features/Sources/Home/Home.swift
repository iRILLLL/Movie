import ComposableArchitecture

public struct Home: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case browseByGenresButtonTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .browseByGenresButtonTapped:
                return .none
            }
        }
    }
}
