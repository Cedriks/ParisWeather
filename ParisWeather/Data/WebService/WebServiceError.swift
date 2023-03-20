//
//  WebServiceError.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

enum WebServiceError: Error {
    case encodingURL
    case invalidURL
    case dataRecoveryFailure
    case responseStatus
    case JSONdecodingFailed
}

