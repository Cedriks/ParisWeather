//
//  DetailView-ViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 19/03/2023.
//

import Foundation

@MainActor class DetailViewModel: ObservableObject {
    let weather: DayWeather
    let city: CityDataModel
    
    let dict: [Int : WeatherDataModel]?
    let keys: [Int]
    let date: Date
    let day: String
    let month: String
    let hourValues: WeatherDataModel
    
    init(weather: DayWeather, city: CityDataModel) {
        self.weather = weather
        self.city = city
        dict = weather.hours
        keys = weather.hours.map{$0.key}.sorted(by: <)
        date = weather.date
        day = date.getHumanReadableDayString()
        month = date.getHumanReadableMonthString()
        hourValues = weather.hours.first!.value
    }
    
    func fullHumanDate() -> String {
        "\(day) \(weather.day) \(month)"
    }
    
    func weatherIcon() -> String {
        (weather.hours.first?.value.weather.first!.icon)!
    }
    // MARK: - Rows Data
    func makeUnitRow(_ name: String, _ value: String, _ unit: String) -> UnitDescription {
        UnitDescription(name: name,
                        value: value,
                        unit: unit)
    }
    
    func descriptionWeather() -> String {
        hourValues.weather.first?.description ?? ""
    }
    
    func temperature() -> UnitDescription {
        makeUnitRow("Temperature",
                    String(format: "%.0f", hourValues.main.temp),
                    "ºC")
    }
    
    func minTemp() -> UnitDescription {
        makeUnitRow("Min",
                    String(format: "%.0f", hourValues.main.temp_min!),
                    "ºC")
    }
    
    func maxTemp() -> UnitDescription {
        makeUnitRow("Max",
                    String(format: "%.0f", hourValues.main.temp_max),
                    "ºC")
    }
    
    func pressure() -> UnitDescription {
        makeUnitRow("Pressure",
                    String(hourValues.main.pressure),
                    "hPa")
    }

    func seaLevel() -> UnitDescription {
        makeUnitRow("Sea level",
                    String(hourValues.main.sea_level),
                    "hPa")
    }
    
    func grndLevel() -> UnitDescription {
        makeUnitRow("Ground level",
                    String(hourValues.main.grnd_level),
                    "hPa")
    }
    
    func humidity() -> UnitDescription {
        makeUnitRow("Humidity",
                    String(hourValues.main.humidity),
                    "%")
    }
    
    
    func clouds() -> UnitDescription {
        makeUnitRow("Cloudiness",
                    String(hourValues.clouds.all),
                    "%")
    }
   
    func wind() -> UnitDescription {
        makeUnitRow("Wind",
                    String(hourValues.wind.speed),
                    "meter/sec")
    }
    
    func windDeg() -> UnitDescription {
        makeUnitRow("Wind direction",
                    String(hourValues.wind.deg),
                    "meter/sec")
    }
    
    func rainLastHour() -> UnitDescription {
        makeUnitRow("Rain last hour",
                    String((hourValues.rain?.h3) ?? 0),
                    "mm")
    }
    
    func visibility() -> UnitDescription {
        makeUnitRow("Average visibility",
                    String(hourValues.visibility),
                    "m")
    }
    
    func sunrise() -> UnitDescription {
        let date : Date =  Date.makeReadableDate(dt: city.sunrise)
        let hour : String = date.toStringHours()
        return makeUnitRow("sunrise",
                    String(hour),
                    "sunrise")
    }
    
    func sunset() -> UnitDescription {
        let date : Date =  Date.makeReadableDate(dt: city.sunset)
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
