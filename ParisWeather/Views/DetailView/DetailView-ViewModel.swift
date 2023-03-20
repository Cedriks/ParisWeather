//
//  DetailView-ViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 19/03/2023.
//

import Foundation
import SwiftUI

@MainActor class DetailViewModel: ObservableObject {
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
    
    // MARK: - Rows Data
    func makeUnitRow(_ name: String, _ value: String, _ unit: String) -> UnitDescription {
        UnitDescription(name: name,
                        value: value,
                        unit: unit)
    }
    
    func makePressure() -> UnitDescription? {
        if let pressure = hourValues?.main.pressure {
            return makeUnitRow("Pressure",
                    String(pressure),
                    "hPa")
        } else {
            return nil
        }
    }
    
    func makeSeaLevel() -> UnitDescription? {
        if let seaLevel = hourValues?.main.pressure {
            return makeUnitRow("Sea level",
                    String(seaLevel),
                    "hPa")
        } else {
            return nil
        }
    }
    
    func makeGrndLevel() -> UnitDescription? {
        if let seaLevel = hourValues?.main.grnd_level {
            return makeUnitRow("Ground level",
                    String(seaLevel),
                    "hPa")
        } else {
            return nil
        }
    }
    
    func makeHumidity() -> UnitDescription?  {
        if let humidity = hourValues?.main.humidity {
            return makeUnitRow("Humidity",
                    String(humidity),
                    "%")
        } else {
            return nil
        }
    }
    
    func makeClouds() -> UnitDescription?  {
        if let clouds = hourValues?.clouds.all {
            return makeUnitRow("Cloudiness",
                    String(clouds),
                    "%")
        } else {
            return nil
        }
    }
    
    func makeWind() -> UnitDescription? {
        if let wind = hourValues?.wind.speed {
            return makeUnitRow("Wind",
                    String(wind),
                    "meter/sec")
        } else {
            return nil
        }
    }
    
    func makeWindDeg() -> UnitDescription? {
        if let wind = hourValues?.wind.deg {
        return makeUnitRow("Wind direction",
                    String(wind),
                    "meter/sec")
        } else {
            return nil
        }
    }
    
    func makeRainLastHour() -> UnitDescription? {
        if let rain = hourValues?.rain?.h3 {
            return makeUnitRow("Rain last hour",
                    String(rain),
                    "mm")
        } else {
            return nil
        }
    }
    
    func makeVisibility() -> UnitDescription?  {
        if let visibility = hourValues?.visibility {
            return makeUnitRow("Average visibility",
                    String(visibility),
                    "m")
        } else {
            return nil
        }
    }
}

struct UnitDescription {
    var name: String
    var value: String
    var unit: String
}
