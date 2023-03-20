//
//  WeatherDataModel.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

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
