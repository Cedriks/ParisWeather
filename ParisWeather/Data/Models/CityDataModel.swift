//
//  CityDataModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

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


