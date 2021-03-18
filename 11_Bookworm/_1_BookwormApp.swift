//
//  _1_BookwormApp.swift
//  11_Bookworm
//
//  Created by Austin Roach on 3/18/21.
//

import SwiftUI

@main
struct _1_BookwormApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
