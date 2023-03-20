//
//  WeatherSysDataModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

struct WeatherSysDataModel: Codable, Hashable {
    let pod: String
    enum CodingKeys: String, CodingKey {
        case pod
    }
}
