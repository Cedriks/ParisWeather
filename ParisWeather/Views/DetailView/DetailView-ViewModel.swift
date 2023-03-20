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
    
  
}

struct UnitDescription {
    var name: String
    var value: String
    var unit: String
}
