import ComposableArchitecture

public struct Account: Reducer {
    
    public init() {}
    
    public struct State: Equatable {
    
        public init() {}
    }
    
    public enum Action: Equatable {
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
