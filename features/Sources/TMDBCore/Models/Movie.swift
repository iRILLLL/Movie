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
        self.posterPath = movie.posterPath
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

extension Array where Element == Movie {
    static let mock: Self = [
        Movie(movie: .init(
            adult: false,
            originalLanguage: "en",
            backdropPath: "/rMvPXy8PUjj1o8o1pzgQbdNCsvj.jpg",
            genreIDS: [28, 12, 53],
            id: 299054,
            originalTitle: "Expend4bles",
            overview: "Armed with every weapon they can get their hands on and the skills to use them, The Expendables are the world’s last line of defense and the team that gets called when all other options are off the table. But new team members with new styles and tactics are going to give “new blood” a whole new meaning.",
            popularity: 1489.424,
            posterPath: "/iwsMu0ehRPbtaSxqiaUDQB9qMWT.jpg",
            releaseDate: "2023-09-15",
            title: "Expend4bles",
            video: false,
            voteAverage: 6.3,
            voteCount: 254
        ))
    ]
}
