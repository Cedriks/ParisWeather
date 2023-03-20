//
//  HomeViewLoaded.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct HomeViewLoaded: View {
    let weather: WeatherModel
    let fiveDayWeather: [DayWeather]
    
    var body: some View {
        let city: CityDataModel = weather.city
        let now: WeatherDataModel = weather.list.first!
        let icon = URL(string: "https://openweathermap.org/img/wn/\(now.weather.first!.icon)@2x.png")
        VStack {
            VStack {
                Text(city.name)
                    .font(.largeTitle)
                Text(Date().getHumanReadableDayString())
                    .fontWeight(.medium)
                AsyncImage(
                    url: icon,
                    content:{ image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100, maxHeight: 100)
                            .padding(.top, -20)
                    },
                    placeholder: {
                     ProgressView()
                            .frame(maxWidth: 100, maxHeight: 100)
                            .padding(.top, 20)
                    }
                )
                Text(now.weather.first!.description)
                    .font(.callout)
                    .padding(.top, -20)
                Text( String(format: "%.0f",now.main.temp) + " ºC")
            }
            List(fiveDayWeather, id: \.self.day) { dayWeather in
                NavigationLink(
                    destination: DetailView(viewModel: DetailViewModel(weather: weather, dayWeather: dayWeather, city: weather.city))
                ) {
                    WeatherRowView(dayWeather: dayWeather)
                }.accessibilityIdentifier("leagueNavigationLink")
            }
            .listStyle(.inset)
            Spacer()
        }
    }
}

struct HomeViewLoaded_Previews: PreviewProvider {
    static var previews: some View {
        let weatherM: WeatherModel = WeatherModel.makePreviewData()
        let weatherDataM : [WeatherDataModel] = weatherM.list
        let daysWeather: [DayWeather] = weatherM.makeIOrderedWeatherDataByDay(fiveDaysData: weatherDataM)
        
        HomeViewLoaded(weather: weatherM, fiveDayWeather: daysWeather )
    }
}

