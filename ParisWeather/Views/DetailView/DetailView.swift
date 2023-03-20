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
                        AsyncImage(
                            url:  URL(string: "https://openweathermap.org/img/wn/\(viewModel.weatherIcon())@2x.png"),
                            content:{ image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 100, maxHeight: 100)
                                    .padding(.horizontal, 4.0)
                            },
                            placeholder: {
                             EmptyView()
                                    .frame(maxWidth: 48)
                            }
                        )
                      
                        HStack(alignment: .top) {
                            Text(viewModel.temperature().value)
                            Text(viewModel.temperature().unit)
                                .font(.caption)
                        }
                        Text(viewModel.descriptionWeather())
                            .font(.footnote)
                    }
                    Spacer()
                    VStack{
                        Image(systemName: viewModel.sunset().unit)
                        Text(viewModel.sunset().value)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
                List {
                    Section ("Temperature"){
                        DetailRowView(unitDesc: viewModel.temperature())
                        DetailRowView(unitDesc: viewModel.minTemp())
                        DetailRowView(unitDesc: viewModel.maxTemp())
                    }
                    Section ("Atmospheric"){
                        DetailRowView(unitDesc: viewModel.pressure())
                        DetailRowView(unitDesc: viewModel.seaLevel())
                        DetailRowView(unitDesc: viewModel.grndLevel())
                        DetailRowView(unitDesc: viewModel.humidity())
                    }
                    Section ("Others"){
                        DetailRowView(unitDesc: viewModel.clouds())
                        HStack {
                            Text(viewModel.wind().name)
                            Spacer()
                            HStack(alignment: .bottom) {
                                Image(systemName: "arrow.up")
                                    .rotationEffect(.degrees(Double(viewModel.hourValues.wind.deg)))
                                Text(viewModel.wind().value)
                                Text(viewModel.wind().unit)
                                    .font(.caption2)
                            }
                        }
                        .padding(.horizontal)
                        DetailRowView(unitDesc: viewModel.rainLastHour())
                        DetailRowView(unitDesc: viewModel.visibility())
                    }
                }
                .listStyle(.grouped)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let weatherM: WeatherModel = WeatherModel.makePreviewData()
        let weatherDataM : [WeatherDataModel] = weatherM.list
        let daysWeather: [DayWeather] = weatherM.makeIOrderedWeatherDataByDay(fiveDaysData: weatherDataM)
        
        DetailView(viewModel: DetailViewModel(weather: daysWeather.first!, city: weatherM.city))
    }
}


