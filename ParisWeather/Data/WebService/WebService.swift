//
//  WebService.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import Foundation


// https://api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}

protocol WebServiceProtocol {
    func makeURL(city: String) throws -> URL
}

final class WebService: WebServiceProtocol {
    //TODO: Stocker la clé dans un fichier 
    private let apiKey: String = "d6b82408b8331dccc474e7d73b1dab70"
    
    private let rootUrl: String
    private let paramCity: String
    private let paramApiKey: String
    
    init(rootUrl: String = "https://api.openweathermap.org/data/2.5/", paramCity: String = "forecast?q=", paramApiKey: String = "&appid=") {
        self.rootUrl = rootUrl
        self.paramCity = paramCity
        self.paramApiKey = paramApiKey
    }
    
    func makeURL(city: String) throws -> URL {
        let urlString = rootUrl + paramCity + city + paramApiKey + apiKey
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            throw WebServiceError.invalidURL
        }
        return url
    }
}
