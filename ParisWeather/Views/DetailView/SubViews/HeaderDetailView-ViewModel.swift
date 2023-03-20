//
//  HeaderDetailView-ViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

@MainActor class HeaderDetailViewModel: ObservableObject {
    let weather: WeatherModel
    let dayWeather: DayWeather
    let hourValues: WeatherDataModel?
    
    init(weather: WeatherModel, dayWeather: DayWeather) {
        self.weather = weather
        self.dayWeather = dayWeather

        if let hourValues = dayWeather.hours.first?.value {
            self.hourValues = hourValues
        } else {
            self.hourValues = nil
        }
    }
    
    func makeUnitRow(_ name: String, _ value: String, _ unit: String) -> UnitDescription {
        UnitDescription(name: name,
                        value: value,
                        unit: unit)
    }
    
    func makeSunrise() -> UnitDescription {
        let date : Date =  Date.makeReadableDate(dt: weather.city.sunrise)
        let hour : String = date.toStringHours()
        return makeUnitRow("sunrise",
                           String(hour),
                           "sunrise")
    }
    
    func makeSunset() -> UnitDescription {
        let date : Date =  Date.makeReadableDate(dt: weather.city.sunset)
        let hour : String = date.toStringHours()
        return makeUnitRow("sunset",
                           String(hour),
                           "sunset")
    }
    func fullHumanDate() -> String {
        "\(dayWeather.date.getHumanReadableDayString()) \(dayWeather.day) \(dayWeather.date.getHumanReadableMonthString())"
    }
    
    func weatherIcon() -> URL? {
        if let iconName =  hourValues?.weather.first?.icon {
            return URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")
        } else {
            return URL(string:"")
        }
    }
    
    
    
    func descriptionWeather() -> String {
        hourValues?.weather.first?.description ?? ""
    }
    
}
