//
//  WeatherRainDataModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

struct WeatherRainDataModel: Codable, Hashable {
    let h3: Double?
    
    enum CodingKeys: String, CodingKey {
        case h3
    }
}
