import ComposableArchitecture

public struct Account: Reducer {
    
    public struct State: Equatable {
        
    }
    
    public enum Action: Equatable {
        
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
