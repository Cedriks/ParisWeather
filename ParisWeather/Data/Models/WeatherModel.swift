//
//  WeatherModel.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import Foundation

struct WeatherModel: Codable {
    let list: [WeatherDataModel]
    let city: CityDataModel
    
    enum CodingKeys: String, CodingKey {
        case list, city
    }
    //MARK: - Methods
    
    func makeFiveDaysWeather(weather: WeatherModel?) -> [WeatherDataModel] {
        let dayTask = Date()
        let lastDay = dayTask.lastDate()
        guard let weatherList = weather?.list else {
            return []
        }
        return weatherList.filter{ Date.makeReadableDate(dt: ($0.dt)) <= lastDay }
    }
    
    func makeIOrderedWeatherDataByDay(fiveDaysData: [WeatherDataModel]) -> [DayWeather] {
        var dayWeatherArray : [DayWeather] = []
        var currentDate: String = onlyDayDate(str: fiveDaysData.first!.dt_txt!)
        var weatherDayDataByHour:  [Int : WeatherDataModel] = [:]
        
        for weatherData in fiveDaysData {
            let weatherDataDate: String = onlyDayDate(str: weatherData.dt_txt!)
            let newDate = Date.makeReadableDate(dt: Int(weatherData.dt))
            let newDateComponents = Calendar.current.dateComponents([.hour, .day, .year, .month], from: newDate)
            let newHour : Int = newDateComponents.hour!
            if (weatherDataDate != currentDate) {
                /// - Save last day datas
                let newDay: DayWeather = DayWeather(date: newDate,
                                                    day: newDateComponents.day!,
                                                    month: newDateComponents.month!,
                                                    year: newDateComponents.year!,
                                                    hours: weatherDayDataByHour)
                dayWeatherArray.append(newDay)
                /// - Save New Day data
                weatherDayDataByHour = [:]
                weatherDayDataByHour[newHour] = weatherData
            } else {
                weatherDayDataByHour[newHour] = weatherData
            }
            currentDate = onlyDayDate(str: weatherData.dt_txt!)
        }
        return dayWeatherArray
    }
    
    func onlyDayDate(str: String) -> String {
        var string = str
        if let spaceRange = string.range(of: " ") {
            string.removeSubrange(spaceRange.lowerBound..<string.endIndex)
        }
        return string
    }
    
    static func makePreviewData() -> WeatherModel {
        var weatherModel: WeatherModel?
        do {
             weatherModel = try CityWeatherNetworker().makeWeatherFromStorage()!
        } catch {
            print(error.localizedDescription)
        }
        return weatherModel!
    }
}
