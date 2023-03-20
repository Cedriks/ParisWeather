//
//  HomeView-ViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation
import CoreData
import SwiftUI

enum SourceData {
    case localStorage,
         webService
}

@MainActor class HomeViewModel: ObservableObject {
    @Published var loadingState = LoadingState.loading
    @Published private(set) var weather: WeatherModel? = nil
    @Published private(set) var fiveDayWeather : [DayWeather] = []
    @Published private(set) var sourceData: SourceData? = .none
    @Published private(set) var errorMessage : String? = nil
    
    private let cityWeatherNetworker: CityWeatherNetworking
    
    init(cityWeatherNetworker: CityWeatherNetworking = CityWeatherNetworker()) {
        self.cityWeatherNetworker = cityWeatherNetworker
    }
    
    func getWeather() async {
        // - Local Storage
//        do {
//            self.weather = try cityWeatherNetworker.makeWeatherFromStorage()
//            if (self.weather != nil) {
//                prepareForPresentation(source: .localStorage)
//            }
//        } catch {
//            errorMessage = error.localizedDescription
//            if(  sourceData == .localStorage || sourceData == .none){
//                loadingState = .failed
//            }
//        }
//        // - API Request
        do {
            self.weather = try await cityWeatherNetworker.fetchWeather()
            prepareForPresentation(source: .webService)
        } catch {
            errorMessage = error.localizedDescription
            if(  sourceData == .webService || sourceData == .none){
                loadingState = .failed
            }
        }
    }
    
    func prepareForPresentation(source: SourceData) {
        /// - Preparing data for presentation
        if let fiveDayWeather = weather?.makeFiveDaysWeather(weather: weather) {
            self.fiveDayWeather = weather!.makeIOrderedWeatherDataByDay(fiveDaysData: fiveDayWeather)
            /// - Update view state
            sourceData = source
            loadingState = .loaded
        }
    }
    
    func clearWeather() {
        self.weather = nil
        /// - Update view state
        loadingState = .loading
    }
}

