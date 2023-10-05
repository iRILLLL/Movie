import Dependencies
import XCTestDynamicOverlay

public struct TMDBClient {
    
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

public enum TMDBClientKey: TestDependencyKey {
    
    public static var previewValue = TMDBClient(
        genreList: unimplemented("\(Self.self).genreList"),
        movieList: unimplemented("\(Self.self).movieList")
    )
    
    public static var testValue = TMDBClient(
        genreList: unimplemented("\(Self.self).genreList"),
        movieList: unimplemented("\(Self.self).movieList")
    )
}

extension DependencyValues {
    public var tmdbClient: TMDBClient {
        get { self[TMDBClientKey.self] }
        set { self[TMDBClientKey.self] = newValue }
    }
}
