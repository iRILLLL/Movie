// https://developer.themoviedb.org/reference/discover-movie
// https://developer.themoviedb.org/reference/trending-movies

public struct MovieListRequest {

    public let type: Type
    public let language: String
    
    public init(
        type: Type,
        language: String = "en-US"
    ) {
        self.language = language
        self.type = type
    }
}

extension MovieListRequest {
    
    public enum `Type` {
        case discover(Discover)
        case trending(Period)
        
        public var endpoint: String {
            switch self {
            case .discover:
                return "/discover/movie"
                
            case let .trending(period):
                return "/trending/movie/\(period.rawValue)"
            }
        }
    }
    
    public struct Discover {
        
        public let genreIDs: [Int]
        
        public init(
            genreIDs: [Int]
        ) {
            self.genreIDs = genreIDs
        }
    }
    
    public enum Period: String {
        case day
        case week
    }
}
