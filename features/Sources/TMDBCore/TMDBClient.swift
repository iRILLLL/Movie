import Dependencies
import XCTestDynamicOverlay

public struct TMDBClient {
    
    public var genreList: @Sendable () async throws -> [Genre]
    
    public init(
        genreList: @escaping @Sendable () async throws -> [Genre]
    ) {
        self.genreList = genreList
    }
}

public enum TMDBClientKey: TestDependencyKey {
    
    public static var previewValue = TMDBClient(
        genreList: unimplemented("\(Self.self).genreList")
    )
    
    public static var testValue = TMDBClient(
        genreList: unimplemented("\(Self.self).genreList")
    )
}

extension DependencyValues {
    public var tmdbClient: TMDBClient {
        get { self[TMDBClientKey.self] }
        set { self[TMDBClientKey.self] = newValue }
    }
}
