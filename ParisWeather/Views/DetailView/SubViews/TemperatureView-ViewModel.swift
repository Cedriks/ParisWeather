//
//  TemperatureView-ViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation
@MainActor class TemperatureViewModel: ObservableObject {
    let hourValues: WeatherDataModel
    
    init(hourValues: WeatherDataModel) {
        self.hourValues = hourValues
    }
    
    func makeUnitRow(_ name: String, _ value: String, _ unit: String) -> UnitDescription {
        UnitDescription(name: name,
                        value: value,
                        unit: unit)
    }
    
    func makeTemperature() -> UnitDescription? {
        return makeUnitRow("Temperature",
                           String(format: "%.0f", hourValues.main.temp),
                           "ºC")
    }
    
    func makeMaxTemp() -> UnitDescription {
        return makeUnitRow("Max",
                           String(format: "%.0f",  hourValues.main.temp_max),
                           "ºC")
    }
    func makeMinTemp() -> UnitDescription {
        return makeUnitRow("Min",
                           String(format: "%.0f", hourValues.main.temp_min!),
                           "ºC")
    }
    
    func makeMaxTempString() -> String {
        let value = makeMaxTemp()
        return value.name + " " + value.value + " " + value.unit
    }
    
    func makeMinTempString() -> String {
        let value = makeMinTemp()
        return value.name + " " + value.value + " " + value.unit
    }
}


