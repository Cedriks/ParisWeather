//
//  WeatherWindDataModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

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
