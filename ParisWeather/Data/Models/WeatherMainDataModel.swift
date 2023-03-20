//
//  WeatherMainDataModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

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
