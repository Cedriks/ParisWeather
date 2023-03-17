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
    
    enum CodingKeys: String, CodingKey {
        case list, city
    }
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
    let dt_txt: String?
    
    
    enum CodingKeys: String, CodingKey {
        case dt,
             main,
             weather,
             clouds,
             wind,
             visibility,
             pop,
             rain,
             sys,
             dt_txt
    }
}

struct WeatherMainData: Codable {
    let temp: Double
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp,
             feels_like,
             temp_min,
             temp_max,
             pressure,
             sea_level,
             grnd_level,
             humidity,
             temp_kf
    }
}

struct WeatherDescriptionData: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    
    enum CodingKeys: String, CodingKey {
        case id,
             main,
             description,
             icon
    }
    
}

struct WeatherCloudData: Codable {
    let all: Int
    enum CodingKeys: String, CodingKey {
        case all
    }
}

struct WeatherWindData: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
    
    enum CodingKeys: String, CodingKey {
        case speed,
             deg,
             gust
    }
}

struct WeatherRainData: Codable {
    let h3: Double?
    
    enum CodingKeys: String, CodingKey {
        case h3
    }
}

struct WeatherSysData: Codable {
    let pod: String
    enum CodingKeys: String, CodingKey {
        case pod
    }
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
    
    enum CodingKeys: String, CodingKey {
        case id,
             name,
             coord,
             country,
             population,
             timezone,
             sunrise,
             sunset
    }
}

struct CityCoordinateData: Codable {
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat,
             lon
    }
}
