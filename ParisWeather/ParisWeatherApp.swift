//
//  ParisWeatherApp.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import SwiftUI

@main
struct ParisWeatherApp: App {
    let persistenceController = PersistenceController.shared


    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
