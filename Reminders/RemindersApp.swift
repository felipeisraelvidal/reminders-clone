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
            CategoriesListView()
                .environmentObject(RemindersManager(context: persistenceController.container.viewContext))
        }
    }
}
