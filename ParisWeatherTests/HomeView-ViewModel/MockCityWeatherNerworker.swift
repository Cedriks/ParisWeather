//
//  MockCityWeatherNerworker.swift
//  ParisWeatherTests
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation
@testable import ParisWeather

final class MockCityWeatherNetworker: CityWeatherNetworking {
    
    var invokedFetchWeather: WeatherModel? = nil
    var stubbedLeague: WeatherModel!
    
    func makeWeatherFromStorage() throws -> WeatherModel? {
        return stubbedLeague
    }
    
    func fetchWeather() async throws -> WeatherModel {
        return stubbedLeague
    }
   
}
