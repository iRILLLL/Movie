import SwiftUI
import Home
import ComposableArchitecture
import Trending

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TrendingView(store: .init(initialState: .init()) {
                Trending()
            })
        }
//        HomeView(store: .init(initialState: .init()) {
//            Home()
//        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
