//
//  WeatherRowView.swift
//  ParisWeather
//
//  Created by Cedrik on 18/03/2023.
//

import SwiftUI

struct WeatherRowView: View {
    let weatherData: WeatherData
    var body: some View {
        HStack {
            Text(Date().makeReadableDate(dt: weatherData.dt).toString())
            Text(String(format: "%.0f", weatherData.tempKelvinToCelcius(weatherData.main.temp)) + " C")
        }
    }
}


//struct WeatherRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherRowView()
//    }
//}
