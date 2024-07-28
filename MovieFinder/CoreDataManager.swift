import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data: \(error.localizedDescription)")
            }
        }
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func addSeenMovie(movie: Movie) {
        let context = persistentContainer.viewContext
        let seenMovie = SeenMovie(context: context)
        seenMovie.title = movie.title
        seenMovie.poster_path = movie.poster_path
        seenMovie.release_date = movie.release_date
        seenMovie.vote_average = movie.vote_average
        saveContext()
    }

    func deleteSeenMovie(seenMovie: SeenMovie) {
        let context = persistentContainer.viewContext
        context.delete(seenMovie)
        saveContext()
    }
}
