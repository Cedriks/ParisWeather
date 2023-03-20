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
    // MARK: - Rows Data
    func makeUnitRow(_ name: String, _ value: String, _ unit: String) -> UnitDescription {
        UnitDescription(name: name,
                        value: value,
                        unit: unit)
    }
    
    func descriptionWeather() -> String {
        hourValues?.weather.first?.description ?? ""
    }
    
    func temperature() -> UnitDescription? {
        if let temp = hourValues?.main.temp {
           return makeUnitRow("Temperature",
                        String(format: "%.0f", temp),
                        "ºC")
        } else {
            return nil
        }
    }
    
    func minTemp() -> UnitDescription? {
        if let temp = hourValues?.main.temp_min {
            return makeUnitRow("Min",
                        String(format: "%.0f", temp),
                        "ºC")
        } else {
            return nil
        }
    }
    
    func makeMaxTemp() -> UnitDescription? {
        if let temp = hourValues?.main.temp_max {
          return makeUnitRow("Max",
                        String(format: "%.0f", temp),
                        "ºC")
        } else {
            return nil
        }
    }
    
    func makePressure() -> any View {
        if let pressure = hourValues?.main.pressure {
            let unit = makeUnitRow("Pressure",
                    String(pressure),
                    "hPa")
            return DetailRowView(unitDesc: unit)
        } else {
            return EmptyView()
        }
    }
    
    func makeSeaLevel() -> any View {
        if let seaLevel = hourValues?.main.pressure {
            let unit = makeUnitRow("Sea level",
                    String(seaLevel),
                    "hPa")
            return DetailRowView(unitDesc: unit)
        } else {
            return EmptyView()
        }
    }
    
    func makeGrndLevel() -> any View {
        if let seaLevel = hourValues?.main.grnd_level {
            let unit = makeUnitRow("Ground level",
                    String(seaLevel),
                    "hPa")
            return DetailRowView(unitDesc: unit)
        } else {
            return EmptyView()
        }
    }
    
    func makeHumidity() -> any View {
        if let humidity = hourValues?.main.humidity {
            let unit = makeUnitRow("Humidity",
                    String(humidity),
                    "%")
            return DetailRowView(unitDesc: unit)
        } else {
            return EmptyView()
        }
    }
    
    func makeClouds() -> any View {
        if let clouds = hourValues?.clouds.all {
           let unit = makeUnitRow("Cloudiness",
                    String(clouds),
                    "%")
            return DetailRowView(unitDesc: unit)
        } else {
            return EmptyView()
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
    
    func makeRainLastHour() -> any View {
        if let rain = hourValues?.rain?.h3 {
        let unit = makeUnitRow("Rain last hour",
                    String(rain),
                    "mm")
            return DetailRowView(unitDesc: unit)
        } else {
            return EmptyView()
        }
    }
    
    func makeVisibility() -> any View {
        if let visibility = hourValues?.visibility {
        let unit = makeUnitRow("Average visibility",
                    String(visibility),
                    "m")
            return DetailRowView(unitDesc: unit)
        } else {
            return EmptyView()
        }
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
}

struct UnitDescription {
    var name: String
    var value: String
    var unit: String
}
