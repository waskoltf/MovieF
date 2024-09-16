import Foundation
import Combine

// Classe MovieViewModel qui implémente le protocole ObservableObject pour être utilisée dans SwiftUI
class MovieViewModel: ObservableObject {
    // Propriétés observables, leur changement sera suivi par l'interface utilisateur
    @Published var query: String = "" // La chaîne de recherche entrée par l'utilisateur
    @Published var movies: [Movie] = [] // Liste des films correspondant à la recherche
    @Published var trendingMovies: [Movie] = [] // Liste des films tendance
    @Published var topRatedMovies: [Movie] = [] // Liste des films les mieux notés
    
    // Instance du service qui gère les appels à l'API
    private var movieService = MovieService()
    // Ensemble de souscriptions pour gérer les flux de données
    private var cancellables = Set<AnyCancellable>()

    // Initialisation du ViewModel
    init() {
        // Observe les changements dans 'query' et déclenche une recherche après un délai de 0.5 seconde
        $query
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // Retarde l'exécution pour éviter les requêtes excessives
            .sink { [weak self] query in
                // Effectue la recherche de films à chaque modification du champ de recherche
                self?.searchMovies(query: query)
            }
            .store(in: &cancellables) // Stocke la souscription pour la maintenir active
        
        // Appelle les méthodes pour récupérer les films tendance et les films les mieux notés au démarrage
        fetchTrendingMovies()
        fetchTopRatedMovies()
    }

    // Méthode pour rechercher des films en utilisant la chaîne de recherche
    func searchMovies(query: String) {
        movieService.searchMovies(query: query) { [weak self] movies in
            // Met à jour la liste des films trouvés
            self?.movies = movies
        }
    }
    
    // Méthode pour récupérer les films tendance
    func fetchTrendingMovies() {
        movieService.fetchTrendingMovies { [weak self] movies in
            // Met à jour la liste des films tendance
            self?.trendingMovies = movies
        }
    }
    
    // Méthode pour récupérer les films les mieux notés
    func fetchTopRatedMovies() {
        movieService.fetchTopRatedMovies { [weak self] movies in
            // Met à jour la liste des films les mieux notés
            self?.topRatedMovies = movies
        }
    }
}
