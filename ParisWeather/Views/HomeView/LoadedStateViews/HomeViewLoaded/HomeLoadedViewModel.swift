//
//  HomeLoadedViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation
import SwiftUI

@MainActor class HomeLoadedViewModel: ObservableObject {
    let weather: WeatherModel
    let fiveDayWeather: [DayWeather]
    let now: WeatherDataModel?
    
    init(weather: WeatherModel, fiveDayWeather: [DayWeather]) {
        self.weather = weather
        self.fiveDayWeather = fiveDayWeather
        
        if let now = weather.list.first {
            self.now = now
        } else {
            self.now = nil
        }
    }
    
    func cityName() -> String {
        weather.city.name
    }
    
    func icon() -> URL? {
        if let icon = now?.weather.first?.icon {
            return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        } else {
            return nil
        }
    }
    
    func weatherDescription() -> String {
        if let firstItem = now?.weather.first {
            return firstItem.description
        } else {
            return ""
        }
    }
    
    func weatherTempString() -> String {
        return String(format: "%.0f",now!.main.temp) + " ºC"
    }
}
