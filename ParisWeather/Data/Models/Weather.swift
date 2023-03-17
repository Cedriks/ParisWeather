//
//  Weather.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import Foundation

struct Weather: Codable {
    let list: [WeatherData]
    let city: CityData
}

struct WeatherData: Codable {
    let dt: Int
    let main: WeatherMainData
    let weather: [WeatherDescriptionData]
    let clouds: WeatherCloudData
    let wind: WeatherWindData
    let visibility: Int
    let pop: Double?
    let rain: WeatherRainData?
    let sys: WeatherSysData
    let dt_txt: String
}

struct WeatherMainData: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
}

struct WeatherDescriptionData: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherCloudData: Codable {
    let all: Int
}

struct WeatherWindData: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct WeatherRainData: Codable {
    let h3: Double
}

struct WeatherSysData: Codable {
    let pod: String
}

struct CityData: Codable {
    let id: Int
    let name: String
    let coord: CityCoordinateData
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct CityCoordinateData: Codable {
    let lat: Double
    let lon: Double
}
