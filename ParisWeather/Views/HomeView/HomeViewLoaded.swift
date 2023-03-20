//
//  HomeViewLoaded.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import SwiftUI

struct HomeViewLoaded: View {
    let weather: WeatherModel
    let fiveDayWeather: [DayWeather]
    
    var body: some View {
        let city: CityDataModel = weather.city
        let now: WeatherDataModel = weather.list.first!
        
        VStack {
            VStack {
                Text(city.name)
                    .font(.largeTitle)
                Text(Date().getHumanReadableDayString())
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(now.weather.first!.icon)@2x.png"))
            }
            List(fiveDayWeather, id: \.self.day) { dayWeather in
                NavigationLink(
                    destination: DetailView(viewModel: DetailView.ViewModel(weather: dayWeather, city: weather.city))
                ) {
                    WeatherRowView(dayWeather: dayWeather)
                }.accessibilityIdentifier("leagueNavigationLink")
            }
            .listStyle(.inset)
            Spacer()
        }
    }
}

//struct HomeViewLoaded_Previews: PreviewProvider {
//    static var previews: some View {
//        let weather: WeatherModel = HomeView.ViewModel(cityName: "Paris").weather!
//        let dayWeather: [DayWeather] = weather.makeIOrderedWeatherDataByDay(fiveDaysData: weather.list)
//        HomeViewLoaded(weather: weather, fiveDayWeather: dayWeather )
//    }
//}

