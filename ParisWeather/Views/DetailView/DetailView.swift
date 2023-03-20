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
                HStack(alignment: .bottom){
                
                    VStack{
                        Image(systemName: viewModel.sunrise().unit)
                        Text(viewModel.sunrise().value)
                            .font(.caption)
                    }
                    Spacer()
                    VStack {
                        Text(viewModel.city.name)
                            .font(.largeTitle)
                        Text(viewModel.fullHumanDate())
                        AsyncImage(url: viewModel.weatherIcon())
                        HStack(alignment: .bottom) {
                            HStack(alignment: .top) {
                                Text(viewModel.temperature().value)
                                Text(viewModel.temperature().unit)
                                    .font(.caption)
                            }
                            VStack{
                                HStack{
                                    Text(viewModel.maxTemp().name + " " + viewModel.maxTemp().value + " " + viewModel.maxTemp().unit)
                                        .font(.caption)
                                        .fontWeight(.light)
                                }
                                HStack{
                                    Text(viewModel.minTemp().name + " " + viewModel.minTemp().value + " " + viewModel.minTemp().unit)
                                        .font(.caption)
                                        .fontWeight(.light)
                                }
                            }
                        }
                        Text(viewModel.descriptionWeather())
                            .font(.footnote)
                    }
                    Spacer()
                    VStack{
                        Image(systemName: $viewModel.sunset().unit)
                        Text(viewModel.sunset().value)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
//                List {
//                    Section ("Atmospheric"){
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
//                }
//                .listStyle(.grouped)
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


