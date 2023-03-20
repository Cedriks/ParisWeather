//
//  HeaderDetailView.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct HeaderDetailView: View {
    @StateObject var viewModel : HeaderDetailViewModel
    
    var body: some View {
        HStack(alignment: .bottom){
            SunriseView(makeSunrise: viewModel.makeSunrise())
            Spacer()
            VStack {
                Text(viewModel.weather.city.name)
                    .font(.largeTitle)
                Text(viewModel.fullHumanDate())
                AsyncImage(url: viewModel.weatherIcon())
                if let hourValues = viewModel.hourValues {
                    TemperatureView(viewModel: TemperatureViewModel(hourValues: hourValues))
                }
                Text(viewModel.descriptionWeather())
                    .font(.footnote)
            }
            Spacer()
            SunsetView(makeSunset: viewModel.makeSunset())
        }
        .padding(.horizontal)
    }
}


struct HeaderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        if let weatherM: WeatherModel = WeatherModel.makePreviewData() {
            let weatherDataM : [WeatherDataModel] = weatherM.list
            let daysWeather: [DayWeather] = weatherM.makeIOrderedWeatherDataByDay(fiveDaysData: weatherDataM)
            
            HeaderDetailView(viewModel: HeaderDetailViewModel(weather: weatherM, dayWeather: daysWeather[1]))
                .previewLayout(.sizeThatFits)
        } else {
            Text("No Preview Data\nLoad HomeView first")
        }
    }
}




