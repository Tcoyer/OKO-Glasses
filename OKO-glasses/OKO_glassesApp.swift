//
//  OKO_glassesApp.swift
//  OKO-glasses
//
//  Created by Reynard Octavius Tan on 21/03/24.
//

import SwiftUI
import SwiftData

@main
struct OKO_glassesApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
//            MainView()
            ObstDetectionView()
        }
//        .modelContainer(sharedModelContainer)
    }
}
