//
//  WeatherRowViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

@MainActor class WeatherRowViewModel: ObservableObject {
    
    let dayWeather: DayWeather
    var humanInfo: WeatherDescriptionDataModel?
    init(dayWeather: DayWeather) {
        self.dayWeather = dayWeather
        humanInfo = dayWeather.hours[13]?.weather.first ?? dayWeather.hours[22]?.weather.first
    }
    
    func icon() -> URL? {
        if let icon = humanInfo?.icon {
            return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        } else {
            return nil
        }
    }
    
    func humanWeekDay() -> String {
        dayWeather.date.getHumanReadableDayString()
    }
    
    func humanWeekDayAndMonth() -> String {
        return "\(dayWeather.day) \(dayWeather.date.getHumanReadableMonthString())"
    }
    
    func humanWeatherDescription() -> String {
        if let description = humanInfo?.description {
            return description
        } else {
            return ""
        }
    }
    
    func hoursKeys() -> [Int] {
        return dayWeather.hours.map{$0.key}.sorted(by: <)
    }
    
    func makeHour(index: Int) -> String {
       return "\(hoursKeys()[index])h"
    }
    
    func makeTempHour(index: Int) -> String {
        return String(format: "%.0f",dayWeather.hours[hoursKeys()[index]]!.main.temp)
    }
}
