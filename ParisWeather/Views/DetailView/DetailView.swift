//
//  DetailView.swift
//  ParisWeather
//
//  Created by Cedrik on 19/03/2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel : ViewModel

    var body: some View {
        VStack {
            VStack {
                Text(viewModel.city.name)
                    .font(.largeTitle)
                Text("date")
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(viewModel.weather.hours.first?.value.weather.first?.icon)@2x.png"))
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let weatherM: WeatherModel = WeatherModel.makePreviewData()
        let weatherDataM : [WeatherDataModel] = weatherM.list
        let daysWeather: [DayWeather] = weatherM.makeIOrderedWeatherDataByDay(fiveDaysData: weatherDataM)
        
        DetailView(viewModel: DetailView.ViewModel(weather: daysWeather.first!, city: weatherM.city))
    }
}
