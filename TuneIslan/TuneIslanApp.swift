//
//  TuneIslanApp.swift
//  TuneIslan
//
//  Created by Apple Esprit on 12/11/2025.
//

import SwiftUI

@main
struct TuneIslanApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
