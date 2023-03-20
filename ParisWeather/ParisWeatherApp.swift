//
//  ParisWeatherApp.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import SwiftUI

@main
struct ParisWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}
