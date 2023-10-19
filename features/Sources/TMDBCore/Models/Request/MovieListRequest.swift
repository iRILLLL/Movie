// https://developer.themoviedb.org/reference/discover-movie
// https://developer.themoviedb.org/reference/trending-movies

public struct MovieListRequest {

    public let type: Type
    public let language: String
    public let page: Int?
    
    public init(
        type: Type,
        language: String = "en-US",
        page: Int? = nil
    ) {
        self.language = language
        self.type = type
        self.page = page
    }
}

extension MovieListRequest {
    
    public enum `Type` {
        case discover(Discover)
        case trending(Period)
        case upcoming
        case topRated
        
        public var endpoint: String {
            switch self {
            case .discover:
                return "/discover/movie"
                
            case let .trending(period):
                return "/trending/movie/\(period.rawValue)"
                
            case .upcoming:
                return "/movie/upcoming"
                
            case .topRated:
                return "/movie/top_rated"
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
    
    public enum Period: String, Equatable {
        case day
        case week
    }
}
