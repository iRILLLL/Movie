import SwiftUI
import Home
import ComposableArchitecture
import Trending

struct ContentView: View {
    var body: some View {
        TrendingMoviesView(store: .init(initialState: .init()) {
            TrendingMovies()
        })
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
