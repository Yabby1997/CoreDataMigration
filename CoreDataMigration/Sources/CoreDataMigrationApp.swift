//
//  CoreDataMigrationApp.swift
//  CoreDataMigration
//
//  Created by Seunghun on 6/1/24.
//

import SwiftUI

@main
struct CoreDataMigrationApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
