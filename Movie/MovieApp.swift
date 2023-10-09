import SwiftUI
import MovieApp
import ComposableArchitecture

@main
struct MovieApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: .init(initialState: AppFeature.State()) {
                    AppFeature()
                }
            )
        }
    }
}
