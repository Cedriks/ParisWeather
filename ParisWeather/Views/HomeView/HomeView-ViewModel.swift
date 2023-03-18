//
//  HomeView-ViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import Foundation
import CoreData

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var cityName: String
        @Published var loadingState = LoadingState.loading
        @Published private(set) var weather: Weather? = nil
        private let cityWeatherNetworker: CityWeatherNetworker

        init(cityName: String, cityWeatherNetworker: CityWeatherNetworker = CityWeatherNetworker()) {
            self.cityName = cityName
            self.cityWeatherNetworker = cityWeatherNetworker
        }

        func getWeather() async {
            do {
                self.weather = try await cityWeatherNetworker.fetchWeather(city: "Paris")
                loadingState = .loaded
            } catch {
                print(error)
                loadingState = .failed
            }
        }
        
        func clearWeather() {
            self.weather = nil
            loadingState = .loading
        }
        
        func saveData(context: NSManagedObjectContext) {
            weather?.list.forEach({ data in
                #warning("TODO: saveData")
//                let entity = 
            })
        }
        
        
    }
}
