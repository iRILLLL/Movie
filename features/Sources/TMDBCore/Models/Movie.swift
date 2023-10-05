import Foundation

public struct Movie: Equatable, Identifiable {
    
    public let id: Int
    public let title: String
    public let releaseDate: String
    public let overview: String
    
    private let posterPath: String
    
    public init(movie: MovieListResponse.Movie) {
        self.id = movie.id
        self.title = movie.title
        self.posterPath = movie.backdropPath
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
    }
    
    public var thumbnailURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w200/" + posterPath)
    }
    
    public var posterURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/original/" + posterPath)
    }
}
