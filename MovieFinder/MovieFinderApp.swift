//
//  MovieFinderApp.swift
//  MovieFinder
//
//  Created by Riboku🗿 on 28/07/2024.
//

import SwiftUI
import Firebase

@main
struct MovieFinderApp: App {
    let persistenceController = CoreDataManager.shared

    init() {
        FirebaseApp.configure()
        
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
        }
    }
}

