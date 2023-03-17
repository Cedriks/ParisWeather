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
#warning("Delete Print")
        print(url)
        do {
            let (data, response) = try await urlSession.data(from: url)
         
            if let httpResponse = response as? HTTPURLResponse {
#warning("Delete Print")
                print("statusCode: \(httpResponse.statusCode)")
                if (httpResponse.statusCode != 200) {
                    throw WebServiceError.responseStatus
                }
            }
            let weather = try CityWeatherNetworker.parseCityWeather(from: data)!
            return weather
        } catch {
            throw error
        }
    }
    
    static func parseCityWeather(from data: Data) throws -> Weather? {
        
        var cityWeatherData: Weather? = nil
        let decoder = JSONDecoder()
        do {
            cityWeatherData = try decoder.decode(Weather.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return cityWeatherData
    }
}
