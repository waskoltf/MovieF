import SwiftUI
import CoreData

struct SeenMoviesView: View {
    @FetchRequest(
        entity: SeenMovie.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SeenMovie.title, ascending: true)]
    ) var seenMovies: FetchedResults<SeenMovie>

    var body: some View {
        NavigationView {
            List {
                ForEach(seenMovies, id: \.self) { seenMovie in
                    HStack {
                        if let posterPath = seenMovie.poster_path {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 75)
                                    .cornerRadius(4)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(seenMovie.title ?? "Unknown Title")
                                .font(.headline)
                            Text(seenMovie.release_date ?? "Unknown Date")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteMovies)
            }
            .navigationTitle("Seen Movies")
            .toolbar {
                EditButton()
            }
        }
    }

    private func deleteMovies(at offsets: IndexSet) {
        for index in offsets {
            let movie = seenMovies[index]
            CoreDataManager.shared.deleteSeenMovie(seenMovie: movie)
        }
    }
}
