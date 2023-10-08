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
        },
        movieList: { request in
            
            let path = request.type.endpoint
            var query: [(String, String?)] = [("language", request.language)]
            
            switch request.type {
            case let .discover(params):
                let genreIDs = params.genreIDs.map(String.init).joined(separator: ",")
                query.append(("with_genres", genreIDs))
                query.append(("include_adult", "false"))
                query.append(("include_video", "false"))
                query.append(("page", "1"))
                query.append(("sort_by", "popularity.desc"))
        
            case .trending:
                break
            }
            
            let request = Request<MovieListResponse>(
                path: path,
                query: query
            )
            let client = APIClient(baseURL: URL(string: "https://api.themoviedb.org/3")) {
                $0.delegate = ClientDelegate()
            }
            let response = try await client.send(request).value
            return response.movies.map(Movie.init)
        }
    )
}

final class ClientDelegate: APIClientDelegate {
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        request.setValue("Bearer \(Secrets.Keys.TMDB.accessToken)", forHTTPHeaderField: "Authorization")
    }
}
