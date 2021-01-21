//
//  final_00757128App.swift
//  final_00757128
//
//  Created by User18 on 2020/12/16.
//

import SwiftUI

@main
struct final_00757128App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            //    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            tmpContentView()
                  .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
