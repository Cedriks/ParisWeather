//
//  WeatherDescriptionDataModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

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
