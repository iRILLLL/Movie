public struct MovieListResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
    public let movies: [Movie]
}

extension MovieListResponse {
    public struct Movie: Codable {
        
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
        
        let adult: Bool
        let backdropPath: String
        let genreIDS: [Int]
        let id: Int
        let originalTitle, overview: String
        let popularity: Double
        let posterPath, releaseDate, title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int
    }
}
