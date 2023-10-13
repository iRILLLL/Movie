import SwiftUI
import TMDBCore
import NukeUI

struct MovieItemView: View {

    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyImage(url:  movie.thumbnailURL) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 172)
                } else if let error = state.error {
                    Text(error.localizedDescription)
                } else {
                    ProgressView()
                }
            }
            VStack(alignment: .leading) {
                Text(movie.releaseDate)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(movie.title)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)
            }
        }
    }
}
