import SwiftUI
import Home
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        HomeView(store: .init(initialState: .init()) {
            Home()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
