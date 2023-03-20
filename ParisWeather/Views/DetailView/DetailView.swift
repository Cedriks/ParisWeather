//
//  DetailView.swift
//  ParisWeather
//
//  Created by Cedrik on 19/03/2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel : DetailViewModel
    
    var body: some View {
        VStack {
            VStack {
                HeaderDetailView(viewModel: HeaderDetailViewModel(weather: viewModel.weather, dayWeather: viewModel.dayWeather))
                List {
//                    Section ("Atmospheric") {
//                        viewModel.makePressure()
//                        viewModel.makeSeaLevel()
//                        viewModel.makeGrndLevel()
//                        viewModel.makeHumidity()
//                    }
//                    Section ("Others"){
//                        viewModel.makeClouds()
//                        HStack {
//                            Text(viewModel.wind().name)
//                            Spacer()
//                            HStack(alignment: .bottom) {
//                                Image(systemName: "arrow.up")
//                                    .rotationEffect(.degrees(Double(viewModel.hourValues.wind.deg)))
//                                Text(viewModel.wind().value)
//                                Text(viewModel.wind().unit)
//                                    .font(.caption2)
//                            }
//                        }
//                        .padding(.horizontal)
//                        viewModel.makeRainLastHour()
//                        viewModel.makeVisibility()
//                    }
                }
                .listStyle(.grouped)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        if let weatherM: WeatherModel = WeatherModel.makePreviewData() {
            let weatherDataM : [WeatherDataModel] = weatherM.list
            let daysWeather: [DayWeather] = weatherM.makeIOrderedWeatherDataByDay(fiveDaysData: weatherDataM)
            
            DetailView(viewModel: DetailViewModel(weather: weatherM,
                                                  dayWeather: daysWeather[1])
            ).previewLayout(.sizeThatFits)
        } else {
            Text("No Preview Data\nLoad HomeView first")
        }
    }
}


