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
}

struct WeatherDataModel: Codable, Hashable {
    let dt: Int
    let main: WeatherMainDataModel
    let weather: [WeatherDescriptionDataModel]
    let clouds: WeatherCloudDataModel
    let wind: WeatherWindDataModel
    let visibility: Int
    let pop: Double?
    let rain: WeatherRainDataModel?
    let sys: WeatherSysDataModel
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

struct WeatherMainDataModel: Codable, Hashable {
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

struct WeatherDescriptionDataModel: Codable, Hashable {
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

struct WeatherCloudDataModel: Codable, Hashable {
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all
    }
}

struct WeatherWindDataModel: Codable, Hashable {
    let speed: Double
    let deg: Int
    let gust: Double
    
    enum CodingKeys: String, CodingKey {
        case speed,
             deg,
             gust
    }
}

struct WeatherRainDataModel: Codable, Hashable {
    let h3: Double?
    
    enum CodingKeys: String, CodingKey {
        case h3
    }
}

struct WeatherSysDataModel: Codable, Hashable {
    let pod: String
    enum CodingKeys: String, CodingKey {
        case pod
    }
}

struct CityDataModel: Codable {
    let id: Int
    let name: String
    let coord: CityCoordinateDataModel
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

struct CityCoordinateDataModel: Codable {
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat,
             lon
    }
}
