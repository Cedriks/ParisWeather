//
//  HomeViewLoaded.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct HomeViewLoaded: View {
    @StateObject var viewModel : HomeLoadedViewModel
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.cityName())
                    .font(.largeTitle)
                Text(Date().getHumanReadableDayString())
                    .fontWeight(.medium)
                AsyncImage(
                    url: viewModel.icon(),
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
                Text(viewModel.weatherDescription())
                    .font(.callout)
                    .padding(.top, -20)
                Text(viewModel.weatherTempString())
            }
            List(viewModel.fiveDayWeather, id: \.self.day) { dayWeather in
                NavigationLink(
                    destination:
                        DetailView(viewModel: DetailViewModel(weather: viewModel.weather,
                                                              dayWeather: dayWeather))
                ) {
                    WeatherRowView(viewModel:
                                    WeatherRowViewModel(dayWeather: dayWeather))
                }.accessibilityIdentifier("leagueNavigationLink")
            }
            .listStyle(.inset)
            Spacer()
        }
    }
}

struct HomeViewLoaded_Previews: PreviewProvider {
    static var previews: some View {
        if let weatherM: WeatherModel = WeatherModel.makePreviewData() {
            let weatherDataM : [WeatherDataModel] = weatherM.list
            let daysWeather: [DayWeather] = weatherM.makeIOrderedWeatherDataByDay(fiveDaysData: weatherDataM)
            
            HomeViewLoaded(viewModel: HomeLoadedViewModel(weather: weatherM, fiveDayWeather: daysWeather))
                .previewLayout(.sizeThatFits)
        } else {
            Text("No Preview Data\nLoad HomeView first")
        }
    }
}
