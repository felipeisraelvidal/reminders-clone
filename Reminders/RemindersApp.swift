//
//  RemindersApp.swift
//  Reminders
//
//  Created by Felipe Israel on 27/09/21.
//

import SwiftUI

@main
struct RemindersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
