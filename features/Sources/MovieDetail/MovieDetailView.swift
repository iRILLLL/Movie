import SwiftUI
import ComposableArchitecture

public struct MovieDetailView: View {
    
    let store: StoreOf<MovieFeature>
    
    public init(store: StoreOf<MovieFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
