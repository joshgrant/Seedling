//
//  SeedlingApp.swift
//  Seedling
//
//  Created by Joshua Grant on 9/13/22.
//

import SwiftUI

@main
struct SeedlingApp: App {
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            MainView()
        }
    }
}
