import Dependencies
import XCTestDynamicOverlay

public struct MovieClient {
    
    public var genreList: @Sendable () async throws -> [Genre]
    public var movieList: @Sendable (MovieListRequest) async throws -> [Movie]
    
    public init(
        genreList: @escaping @Sendable () async throws -> [Genre],
        movieList: @escaping @Sendable (MovieListRequest) async throws -> [Movie]
    ) {
        self.genreList = genreList
        self.movieList = movieList
    }
}

public enum MovieClientKey: TestDependencyKey {
    
    public static var previewValue = MovieClient(
        genreList: unimplemented("\(Self.self).genreList"),
        movieList: unimplemented("\(Self.self).movieList")
    )
    
    public static var testValue = MovieClient(
        genreList: unimplemented("\(Self.self).genreList"),
        movieList: unimplemented("\(Self.self).movieList")
    )
}

extension DependencyValues {
    public var movieClient: MovieClient {
        get { self[MovieClientKey.self] }
        set { self[MovieClientKey.self] = newValue }
    }
}
