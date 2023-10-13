import SwiftUI
import TMDBCore

struct GenreItemView: View {
    
    let genre: Genre
    
    var body: some View {
        Text(genre.name)
    }
}
