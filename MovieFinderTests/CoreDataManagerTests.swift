import XCTest
import CoreData
@testable import MovieFinder

class CoreDataManagerTests: XCTestCase {

    var coreDataManager: CoreDataManager!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Initialiser CoreDataManager avec un store en mémoire pour les tests
        coreDataManager = CoreDataManager(isTesting: true)
        managedObjectContext = coreDataManager.persistentContainer.viewContext
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        managedObjectContext = nil
        try super.tearDownWithError()
    }

    func testAddSeenMovie() throws {
        let movie = Movie(id: 1, title: "Test Movie", overview: "Test Overview", release_date: "2023-01-01", poster_path: "/testpath.jpg", vote_average: 8.0)
        coreDataManager.addSeenMovie(movie: movie)

        let fetchRequest: NSFetchRequest<SeenMovie> = SeenMovie.fetchRequest()
        let results = try managedObjectContext.fetch(fetchRequest)

        XCTAssertTrue(results.contains { $0.title == movie.title })
    }

    func testDeleteSeenMovie() throws {
        let movie = Movie(id: 1, title: "Test Movie", overview: "Test Overview", release_date: "2023-01-01", poster_path: "/testpath.jpg", vote_average: 8.0)
        coreDataManager.addSeenMovie(movie: movie)

        let fetchRequest: NSFetchRequest<SeenMovie> = SeenMovie.fetchRequest()
        var results = try managedObjectContext.fetch(fetchRequest)
        XCTAssertTrue(results.contains { $0.title == movie.title })

        if let seenMovie = results.first(where: { $0.title == movie.title }) {
            coreDataManager.deleteSeenMovie(seenMovie: seenMovie)
        }

        // Rafraîchir le contexte pour s'assurer qu'il ne retourne pas de résultats mis en cache
        managedObjectContext.refreshAllObjects()

        results = try managedObjectContext.fetch(fetchRequest)
        XCTAssertFalse(results.contains { $0.title == movie.title })
    }
}
