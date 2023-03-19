//
//  HomeView-ViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import Foundation
import CoreData

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var cityName: String
        @Published var loadingState = LoadingState.loading
        @Published private(set) var weather: WeatherModel? = nil
        private let cityWeatherNetworker: CityWeatherNetworker
        
        @Published var fiveDayWeather : [DayWeather] = []
     
        init(cityName: String, cityWeatherNetworker: CityWeatherNetworker = CityWeatherNetworker()) {
            self.cityName = cityName
            self.cityWeatherNetworker = cityWeatherNetworker
        }
        
        func getWeather(context: NSManagedObjectContext) async {
            do {
                /// - Request
                self.weather = try await cityWeatherNetworker.fetchWeather(city: "Paris")
                /// - Preparing data for presentation
                let fiveDayWeather = makeFiveDaysWeather()
                self.fiveDayWeather = makeIOrderedWeatherDataByDay(fiveDaysData: fiveDayWeather)
                DispatchQueue.main.async {
                    self.saveData(context: context)
                }
                /// - Update view state
                loadingState = .loaded
            } catch {
                print(error)
                loadingState = .failed
            }
        }
        
        func clearWeather() {
            self.weather = nil
            /// - Update view state
            loadingState = .loading
        }
        
        func saveData(context: NSManagedObjectContext) {
            let entityWeather = Weather(context: context)
            /// - WeatherDatas
            entityWeather.list = []
            entityWeather.list?.addingObjects(from: weather!.list)
            
            /// - CityCoordinateData
            let cityCoordinateData = CityCoordinateData(context: context)
            cityCoordinateData.lat = 48.8534
            cityCoordinateData.lon = 2.3488
            
            /// - CityData
            let entityCity = CityData(context: context)
            
            entityCity.id = 2988507
            entityCity.name = "Paris"
            entityCity.country = "FR"
            entityCity.population = 2138551
            entityCity.timezone = 3600
            entityCity.sunrise = 1679032848
            entityCity.sunset = 1679075846
            entityCity.coord = cityCoordinateData
            
            /// - Weather
            entityWeather.city = entityCity
        
            do {
                try context.save()
                print("✅ success")
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func makeFiveDaysWeather() -> [WeatherDataModel] {
            let dayTask = Date()
            let lastDay = dayTask.lastDate()
            guard let weatherList = weather?.list else {
                return []
            }
            return weatherList.filter{ Date().makeReadableDate(dt: ($0.dt)) <= lastDay }
        }
        
        func makeIOrderedWeatherDataByDay(fiveDaysData: [WeatherDataModel]) -> [DayWeather] {
            var dayWeatherArray : [DayWeather] = []
            var currentDate: String = onlyDayDate(str: fiveDaysData.first!.dt_txt!)
            var weatherDayDataByHour:  [Int : WeatherDataModel] = [:]
            
            for weatherData in fiveDaysData {
                let weatherDataDate: String = onlyDayDate(str: weatherData.dt_txt!)
                let newDate = Date().makeReadableDate(dt: Int(weatherData.dt))
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
    }
}
