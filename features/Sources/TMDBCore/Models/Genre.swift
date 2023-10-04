public struct Genre: Equatable, Identifiable {
    
    public let id: Int
    public let name: String
    
    public init(genre: GenreListResponse.Genre) {
        self.id = genre.id
        self.name = genre.name
    }
}
