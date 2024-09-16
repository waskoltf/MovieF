//
//  MovieFinderUITests.swift
//  MovieFinderUITests
//
//  Created by Riboku🗿 on 28/07/2024.
//

import XCTest

final class MovieFinderUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
     
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func testMovieDetailView() throws {
        // Simuler la recherche d'un film
        let searchField = app.textFields["Search Movies"]
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("Inception\n") // '\n' simule l'appui sur Entrée

        // Attendre que le résultat de recherche apparaisse et le sélectionner
        let movieCell = app.staticTexts["Inception"]
        XCTAssertTrue(movieCell.waitForExistence(timeout: 5))
        movieCell.tap()

        // Vérifier que la vue de détail affiche les informations correctes
        let detailTitle = app.staticTexts["Inception"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 5))

        // Vérifier la présence de la date de sortie et de la note
        let releaseDate = app.staticTexts["releaseDate"]
        XCTAssertTrue(releaseDate.waitForExistence(timeout: 5))

        let rating = app.staticTexts["rating"]
        XCTAssertTrue(rating.waitForExistence(timeout: 5))

        // Vérifier la présence du résumé
        let overview = app.staticTexts["overview"]
        XCTAssertTrue(overview.waitForExistence(timeout: 5))

        // Vérifier la présence du bouton 'Mark as seen' et appuyez dessus
        let markAsSeenButton = app.buttons["markAsSeenButton"]
        XCTAssertTrue(markAsSeenButton.waitForExistence(timeout: 5))
        markAsSeenButton.tap()

        // Naviguer vers l'onglet Films vus
        app.tabBars.buttons["Seen Movies"].tap()

        // Vérifier que le film apparaît dans la liste des films vus
        let seenMovie = app.staticTexts["Inception"]
        XCTAssertTrue(seenMovie.waitForExistence(timeout: 5))
    }

    func testSeenMoviesView() throws {
        // Naviguer directement vers l'onglet Films vus
        app.tabBars.buttons["Seen Movies"].tap()

        // Vérifier que la vue Films vus s'affiche correctement
        XCTAssertTrue(app.navigationBars["Seen Movies"].exists)

        // S'il y a des films dans la liste, effectuer une suppression
        if app.tables.cells.count > 0 {
            let firstSeenMovie = app.tables.cells.element(boundBy: 0)
            XCTAssertTrue(firstSeenMovie.exists)

            firstSeenMovie.swipeLeft() // Balayer vers la gauche pour révéler le bouton de suppression
            firstSeenMovie.buttons["Delete"].tap()

            XCTAssertFalse(firstSeenMovie.exists)
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
