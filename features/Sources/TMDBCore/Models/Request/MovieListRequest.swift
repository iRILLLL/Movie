public struct MovieListRequest {
    
    public let genreIDs: [Int]
    
    public init(genreIDs: [Int]) {
        self.genreIDs = genreIDs
    }
}
