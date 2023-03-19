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
    let cityName: String = "Paris"


    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeView.ViewModel(cityName: cityName))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
