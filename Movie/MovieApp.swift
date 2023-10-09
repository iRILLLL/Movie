import SwiftUI
import MovieApp
import ComposableArchitecture

@main
struct MovieApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AppView(
                    store: .init(initialState: AppFeature.State()) {
                        AppFeature()
                    }
                )
            }
        }
    }
}
