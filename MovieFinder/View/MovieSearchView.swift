import SwiftUI

struct MovieSearchView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    TextField("Search Movies", text: $viewModel.query)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    if !viewModel.query.isEmpty {
                        Text("Search Results")
                            .font(.title2)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.movies) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        MovieCardView(movie: movie)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Text("Trending Movies")
                        .font(.title2)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.trendingMovies) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieCardView(movie: movie)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Text("Top Rated Movies")
                        .font(.title2)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.topRatedMovies) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieCardView(movie: movie)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationTitle("Movie Finder")
            }
        }
    }
}

struct MovieCardView: View {
    var movie: Movie

    var body: some View {
        VStack(alignment: .center) {
            if let posterPath = movie.poster_path {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 225)
                .cornerRadius(8)
                .clipped()
            }
            Text(movie.title)
                .font(.headline)
                .lineLimit(1)
                .frame(width: 150, alignment: .center)
            Text(movie.release_date)
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: 150, alignment: .center)
        }
        .frame(width: 150)
    }
}
