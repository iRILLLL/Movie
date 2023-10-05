import SwiftUI
import TMDBCore

struct MovieView: View {

    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: movie.thumbnailURL,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 172)
                },
                placeholder: {
                    ProgressView()
                }
            )
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
