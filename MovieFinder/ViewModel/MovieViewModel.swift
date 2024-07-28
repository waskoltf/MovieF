import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var movies: [Movie] = []
    @Published var trendingMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    private var movieService = MovieService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        $query
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                self?.searchMovies(query: query)
            }
            .store(in: &cancellables)
        
        fetchTrendingMovies()
        fetchTopRatedMovies()
    }

    func searchMovies(query: String) {
        movieService.searchMovies(query: query) { [weak self] movies in
            self?.movies = movies
        }
    }
    
    func fetchTrendingMovies() {
        movieService.fetchTrendingMovies { [weak self] movies in
            self?.trendingMovies = movies
        }
    }
    
    func fetchTopRatedMovies() {
        movieService.fetchTopRatedMovies { [weak self] movies in
            self?.topRatedMovies = movies
        }
    }
}
