//
//  CityWeatherNetworker.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import Foundation

protocol CityWeatherNetworking {
    func fetchWeather(city:String) async throws -> Weather
}

final class CityWeatherNetworker: CityWeatherNetworking {
    
    private let webService: WebServiceProtocol
    private let urlSession: URLSession
    
    init(webService: WebServiceProtocol = WebService(), urlSession: URLSession = .shared) {
        self.webService = webService
        self.urlSession = urlSession
    }
    
    func fetchWeather(city: String) async throws -> Weather {
        guard let url: URL = try? webService.makeURL(city: city) else {
            throw WebServiceError.invalidURL
        }
        
        do {
            let (data, response) = try await urlSession.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
#warning("Delete Print")
                print("statusCode: \(httpResponse.statusCode)")
                if (httpResponse.statusCode != 200) {
                    throw WebServiceError.responseStatus
                }
            }
            
            return try CityWeatherNetworker.parseCityWeather(from: data)!
        } catch {
            throw error
        }
    }
    
    static func parseCityWeather(from data: Data) throws -> Weather? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let cityWeatherData = try? decoder.decode(Weather.self, from: data) else {
            throw WebServiceError.JSONdecodingFailed
        }
        
        return cityWeatherData
    }
}
