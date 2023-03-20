//
//  WeatherCloudDataModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

struct WeatherCloudDataModel: Codable, Hashable {
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all
    }
}
