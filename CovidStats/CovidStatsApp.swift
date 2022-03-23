//
//  CovidStatsApp.swift
//  CovidStats
//
//  Created by 中出翔也 on 2022/03/22.
//

import SwiftUI

@main
struct CovidStatsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
