import SwiftUI
import ComposableArchitecture

public struct SwiftUIView: View {
    
    let store: StoreOf<Account>
    
    public init(store: StoreOf<Account>) {
        self.store = store
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
