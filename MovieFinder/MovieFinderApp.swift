//
//  MovieFinderApp.swift
//  MovieFinder
//
//  Created by Riboku🗿 on 28/07/2024.
//

import SwiftUI

@main
struct MovieFinderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
