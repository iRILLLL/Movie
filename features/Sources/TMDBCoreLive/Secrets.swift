import Foundation

enum Secrets {
    enum Keys {
        enum TMDB {
            
            static var apiKey: String {
                Secrets.valueFor(key: "TMDB_API_KEY")
            }
            
            static var accessToken: String {
                Secrets.valueFor(key: "TMDB_ACCESS_TOKEN")
            }
        }
    }
}

private extension Secrets {
    static func valueFor(key: String) -> String {
        guard
            let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary[key] as? String
        else { fatalError("Value for \(key) not found.") }
        return value
    }
}
