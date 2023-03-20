//
//  DayWeather.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

struct DayWeather {
    let date: Date
    let day: Int
    let month: Int
    let year: Int
    
    let hours: [Int: WeatherDataModel]
    
    init(date: Date, day: Int, month: Int, year: Int, hours: [Int : WeatherDataModel]) {
        self.date = date
        self.day = day
        self.month = month
        self.year = year
        self.hours = hours
    }
}
