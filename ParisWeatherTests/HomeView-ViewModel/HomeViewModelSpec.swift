//
//  HomeViewModelSpec.swift
//  ParisWeatherTests
//
//  Created by Cedrik on 20/03/2023.
//

import XCTest
@testable import ParisWeather


final class HomeViewModelSpec: XCTestCase {

    var viewModel: HomeViewModel!
    var mockWeather: MockCityWeatherNetworker!
    
    @MainActor override func setUp() {
        mockWeather = MockCityWeatherNetworker()
        
        mockWeather.stubbedLeague = WeatherModel.makePreviewData()
        viewModel = HomeViewModel(cityName: "Paris", cityWeatherNetworker: mockWeather! )
    }
    
    @MainActor func testmakeWeatherFromStorageToTrue() async {
        await viewModel.getWeather()
        XCTAssertNotNil(mockWeather.stubbedLeague)
        XCTAssertEqual(viewModel.weather?.city.id, mockWeather.stubbedLeague.city.id)
    }
}
