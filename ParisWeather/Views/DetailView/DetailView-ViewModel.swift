//
//  DetailView-ViewModel.swift
//  ParisWeather
//
//  Created by Cedrik on 19/03/2023.
//

import Foundation

extension DetailView {
    @MainActor class ViewModel: ObservableObject {
        let weather: DayWeather
        let city: CityDataModel
        init(weather: DayWeather, city: CityDataModel) {
            self.weather = weather
            self.city = city
        }
    }
}
