import ComposableArchitecture

public struct Home: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case view(ViewAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case browseByGenresButtonTapped
        }
        
        public enum DelegateAction: Equatable {
            case browseByGenresButtonTapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                switch action {
                case .browseByGenresButtonTapped:
                    return .send(.delegate(.browseByGenresButtonTapped))
                }
                
            case .delegate:
                return .none
            }
        }
    }
}
