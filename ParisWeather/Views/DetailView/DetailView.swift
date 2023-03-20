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
                    Section ("Atmospheric") {
                        DetailRowView(unitDesc: viewModel.makePressure())
                        DetailRowView(unitDesc: viewModel.makeSeaLevel())
                        DetailRowView(unitDesc: viewModel.makeGrndLevel())
                        DetailRowView(unitDesc: viewModel.makeHumidity())
                    }
                    Section ("Others"){
                        DetailRowView(unitDesc: viewModel.makeClouds())
                        HStack {
                            Text(viewModel.makeWind()?.name ?? "")
                            Spacer()
                            if(viewModel.makeWind() != nil) {
                                HStack(alignment: .bottom) {
                                    Image(systemName: "arrow.up")
                                        .rotationEffect(.degrees(Double(viewModel.hourValues?.wind.deg ?? 0)))
                                    Text(viewModel.makeWind()?.value ?? "")
                                    Text(viewModel.makeWind()?.unit ?? "")
                                        .font(.caption2)
                                }
                            }
                        }
                        .padding(.horizontal)
                        DetailRowView(unitDesc: viewModel.makeRainLastHour())
                        DetailRowView(unitDesc: viewModel.makeVisibility())
                    }
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


