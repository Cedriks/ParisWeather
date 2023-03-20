//
//  CityWeatherNetworker.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import Foundation

protocol CityWeatherNetworking {
    func fetchWeather(city:String) async throws -> WeatherModel
    func makeWeatherFromStorage() throws -> WeatherModel?
    func decodeWeatherModel(from data: Data) throws -> WeatherModel?
    func encodeWeatherModel(weatherModel: WeatherModel) throws -> String
}

final class CityWeatherNetworker: CityWeatherNetworking {
    
    private let webService: WebServiceProtocol
    private let urlSession: URLSession
    private let localFileName: String = "weatherInfos"
    
    init(webService: WebServiceProtocol = WebService(), urlSession: URLSession = .shared) {
        self.webService = webService
        self.urlSession = urlSession
    }

    
    func makeWeatherFromStorage() throws -> WeatherModel? {
        do {
            /// - Get Data from local storage
            let localDataWeather : Data =  try JSONSerialization.loadJSON(withFilename: "weatherInfos")!
            let weatherModel = try decodeWeatherModel(from: localDataWeather)!
            return weatherModel
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func fetchWeather(city: String) async throws -> WeatherModel {
        guard let url: URL = try? webService.makeURL(city: city) else {
            throw WebServiceError.invalidURL
        }
        print(url)
        do {
            let (data, response) = try await urlSession.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode != 200) {
                    print(httpResponse.statusCode)
                    throw WebServiceError.responseStatus
                }
            }
            let weatherModel = try decodeWeatherModel(from: data)!
            let endcodeStringWeather = try encodeWeatherModel(weatherModel: weatherModel)
            try JSONSerialization.saveToFile(jsonString: endcodeStringWeather, toFilename: localFileName)
            return weatherModel
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func decodeWeatherModel(from data: Data) throws -> WeatherModel? {
        var cityWeatherData: WeatherModel? = nil
        let decoder = JSONDecoder()
        do {
            cityWeatherData = try decoder.decode(WeatherModel.self, from: data)
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
    
    func encodeWeatherModel(weatherModel: WeatherModel) throws -> String {
        let weather: WeatherModel = weatherModel
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let encodeWeather = try jsonEncoder.encode(weather)
            let endcodeStringWeather = String(data: encodeWeather, encoding: .utf8)!
            return endcodeStringWeather
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
