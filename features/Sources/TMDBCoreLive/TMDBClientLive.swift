import Foundation
import Dependencies
import TMDBCore
import Get

extension TMDBClientKey: DependencyKey {
    
    public static let liveValue: TMDBClient = .init(
        genreList: {
            let path = "/genre/tv/list"
            let request = Request<GenreListResponse>(
                path: path,
                query: [("language", "en")]
            )
            let client = APIClient(baseURL: URL(string: "https://api.themoviedb.org/3")) {
                $0.delegate = ClientDelegate()
            }
            let response = try await client.send(request).value
            return response.genres.map(Genre.init)
        }
    )
}

final class ClientDelegate: APIClientDelegate {
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        request.setValue("Bearer \(Secrets.Keys.TMDB.accessToken)", forHTTPHeaderField: "Authorization")
    }
}
