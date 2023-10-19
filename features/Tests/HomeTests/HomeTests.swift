import XCTest
import ComposableArchitecture

@testable import Home
@testable import TMDBCore

@MainActor
final class HomeTests: XCTestCase {
    
    func test_onTask() async throws {
        
        let store = TestStore(initialState: Home.State()) {
            Home()
        } withDependencies: {
            $0.movieClient.movieList = { _ in .mock }
        }
        
        await store.send(.view(.onTask))
        
        await store.receive(._internal(.movieListResponse(.topRated, .success(.mock))))
        await store.receive(._internal(.movieListResponse(.upcoming, .success(.mock))))
        await store.receive(._internal(.movieListResponse(.nowPlaying, .success(.mock))))
        await store.receive(._internal(.movieListResponse(.popular, .success(.mock))))
    }
}
