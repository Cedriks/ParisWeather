//
//  HomeView-ViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import Foundation
import CoreData
import SwiftUI

enum SourceData {
    case localStorage, webService
}

@MainActor class HomeViewModel: ObservableObject {
    @Published private(set) var cityName: String
    @Published var loadingState = LoadingState.loading
    @Published private(set) var weather: WeatherModel? = nil
    
    private let cityWeatherNetworker: CityWeatherNetworker
    
    @Published var fiveDayWeather : [DayWeather] = []
    
    @Published var sourceData: SourceData? = .none
    @Published var errorMessage : String? = nil
    
    init(cityName: String, cityWeatherNetworker: CityWeatherNetworker = CityWeatherNetworker()) {
        self.cityName = cityName
        self.cityWeatherNetworker = cityWeatherNetworker
    }
    
    func getWeather() async {
        /// - Local Storage
        do {
            self.weather = try cityWeatherNetworker.makeWeatherFromStorage()
            if (self.weather != nil) {
                /// - Preparing data for presentation
                if let fiveDayWeather = weather?.makeFiveDaysWeather(weather: weather) {
                    self.fiveDayWeather = weather!.makeIOrderedWeatherDataByDay(fiveDaysData: fiveDayWeather)
                    /// - Update view state
                    sourceData = .localStorage
                    loadingState = .loaded
                }
            }
        } catch {
            print(error)
        }
        /// - API Request
        do {
            /// - Request
            self.weather = try await cityWeatherNetworker.fetchWeather(city: "Paris")
            /// - Preparing data for presentation
            if let fiveDayWeather = weather?.makeFiveDaysWeather(weather: weather) {
                self.fiveDayWeather = weather!.makeIOrderedWeatherDataByDay(fiveDaysData: fiveDayWeather)
                /// - Update view state
                sourceData = .webService
                loadingState = .loaded
            }
        } catch {
            
            errorMessage = error.localizedDescription
            if(  sourceData == .webService || sourceData == .none){
                loadingState = .failed
            }
        }
    }
    
    func clearWeather() {
        self.weather = nil
        /// - Update view state
        loadingState = .loading
    }
}

