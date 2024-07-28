import SwiftUI

struct MovieDetailView: View {
    var movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let posterPath = movie.poster_path {
                    GeometryReader { geometry in
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .frame(height: 300)
                }
                
                Text(movie.title)
                    .font(.largeTitle)
                    .padding(.top)
                    .padding(.horizontal)

                Text("Release Date: \(movie.release_date)")
                    .font(.subheadline)
                    .padding(.top, 5)
                    .padding(.horizontal)

                Text("Rating: \(movie.vote_average, specifier: "%.1f")/10")
                    .font(.subheadline)
                    .padding(.top, 5)
                    .padding(.horizontal)

                Text(movie.overview)
                    .padding(.top, 10)
                    .padding(.horizontal)

                Button(action: {
                    CoreDataManager.shared.addSeenMovie(movie: movie)
                }) {
                    Text("Mark as Seen")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(movie.title)
    }
}

