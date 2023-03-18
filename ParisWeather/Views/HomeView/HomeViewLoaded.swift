//
//  HomeViewLoaded.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import SwiftUI

struct HomeViewLoaded: View {
    let weather: Weather
    
    var body: some View {
        let city: CityData = weather.city
        let list: [WeatherData] = weather.list
        let now: WeatherData = weather.list.first!
        
        VStack {
            VStack {
                Text(city.name)
                    .font(.largeTitle)
                Text(Date().getHumanReadableDayString())
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(now.weather.first!.icon)@2x.png"))
            }
            List(list, id: \.self.dt) { weather in
                WeatherRowView(weatherData: weather)
            }
            Spacer()
        }
        
    }
}

//struct HomeViewLoaded_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeViewLoaded()
//    }
//}

