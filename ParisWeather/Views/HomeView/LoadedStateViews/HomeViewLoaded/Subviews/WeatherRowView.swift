//
//  WeatherRowView.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct WeatherRowView: View {
    var viewModel:  WeatherRowViewModel
    var body: some View {
      HStack {
            ZStack {
                AsyncImage(url: viewModel.icon())
                    .frame(width: 20, height: 20)
                    .opacity(0.4)
                    .padding([.leading, .top],20)
                VStack(alignment: .leading) {
                    Text(viewModel.humanWeekDay())
                        .multilineTextAlignment(.leading)
                        .fontWeight(.semibold)
                    Text(viewModel.humanWeekDayAndMonth())
                        .fontWeight(.medium)
                }
            }
            .frame(maxWidth: 120,maxHeight: 80)
            Spacer()
                .frame(maxWidth: 30)
            VStack(alignment: .leading) {
                Text(viewModel.humanWeatherDescription())
                    .font(.callout)
                    .fontWeight(.medium)
                Spacer()
                Text("Temperatures ºC")
                    .font(.caption)
                    .fontWeight(.medium)
                HStack(alignment: .top) {
                    ForEach(viewModel.hoursKeys().indices) {index in
                        VStack {
                            Text(viewModel.makeHour(index: index))
                                .font(.caption2)
                            Text(viewModel.makeTempHour(index: index))
                                .font(.footnote)
                                .fontWeight(.medium)
                        }.frame(width: 20)
                    }
                }
            }
            .padding(.vertical)
        }
        .frame(height: 100)
    }
}

struct WeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        if let weatherM: WeatherModel = WeatherModel.makePreviewData() {
            let weatherDataM : [WeatherDataModel] = weatherM.list
            let daysWeather: [DayWeather] = weatherM.makeIOrderedWeatherDataByDay(fiveDaysData: weatherDataM)
            WeatherRowView(viewModel: WeatherRowViewModel(dayWeather: daysWeather[1]))
                .previewLayout(.sizeThatFits)
        } else {
            Text("No Preview Data\nLoad HomeView first")
        }
    }
}
