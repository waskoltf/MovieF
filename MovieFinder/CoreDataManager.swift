import CoreData

// Classe pour gérer les opérations de Core Data
class CoreDataManager {
    // Singleton pour s'assurer qu'il n'y a qu'une seule instance de CoreDataManager dans l'application
    static let shared = CoreDataManager()

    // Conteneur persistant qui encapsule tout ce qui est nécessaire pour utiliser Core Data
    let persistentContainer: NSPersistentContainer
    
    // Initialisation de la classe
    init(isTesting: Bool = false) {
        // Initialisation du conteneur persistant avec le modèle de données "MovieModel"
        persistentContainer = NSPersistentContainer(name: "MovieModel")
        
        // Si le mode de test est activé, utiliser un magasin en mémoire pour éviter de sauvegarder sur le disque
        if isTesting {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            persistentContainer.persistentStoreDescriptions = [description]
        }
        
        // Charger les magasins persistants
        persistentContainer.loadPersistentStores { description, error in
            // Si une erreur survient lors du chargement, arrêter l'application et afficher l'erreur
            if let error = error {
                fatalError("Unable to initialize Core Data: \(error.localizedDescription)")
            }
        }
    }

    // Fonction pour sauvegarder le contexte si des changements ont été effectués
    func saveContext() {
        let context = persistentContainer.viewContext
        // Vérifier s'il y a des changements dans le contexte
        if context.hasChanges {
            do {
                // Tenter de sauvegarder les changements
                try context.save()
            } catch {
                // Gérer l'erreur si la sauvegarde échoue
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // Fonction pour ajouter un film à la liste des films vus
    func addSeenMovie(movie: Movie) {
        let context = persistentContainer.viewContext
        // Créer un nouvel objet SeenMovie dans le contexte
        let seenMovie = SeenMovie(context: context)
        // Définir les propriétés du film vu à partir de l'objet Movie
        seenMovie.title = movie.title
        seenMovie.poster_path = movie.poster_path
        seenMovie.release_date = movie.release_date
        seenMovie.vote_average = movie.vote_average
        // Sauvegarder le contexte avec le nouveau film vu
        saveContext()
    }

    // Fonction pour supprimer un film de la liste des films vus
    func deleteSeenMovie(seenMovie: SeenMovie) {
        let context = persistentContainer.viewContext
        // Supprimer l'objet SeenMovie du contexte
        context.delete(seenMovie)
        // Sauvegarder le contexte après la suppression
        saveContext()
    }
}
