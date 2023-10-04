public struct GenreListResponse: Codable {
    public let genres: [Genre]
}

extension GenreListResponse {
    public struct Genre: Codable {
        let id: Int
        let name: String
    }
}
