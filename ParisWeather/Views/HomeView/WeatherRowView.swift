//
//  WeatherRowView.swift
//  ParisWeather
//
//  Created by Cedrik on 18/03/2023.
//

import SwiftUI

struct WeatherRowView: View {
    var dayWeather : DayWeather
    
    //    (dayWeather.hours.first!.weather.first?.icon)!
    var body: some View {
        let dict = dayWeather.hours
        let keys = dict.map{$0.key}.sorted(by: <)
        let humanDay = dayWeather.date.getHumanReadableDayString()
        let humanMonth = dayWeather.date.getHumanReadableMonthString()
        let humanInfo = dayWeather.hours[13]!.weather.first!
        
        HStack {
            ZStack {
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(humanInfo.icon)@2x.png"))
                    .frame(width: 20, height: 20)
                    .opacity(0.2)
                VStack(alignment: .leading) {
                    Text("\(humanDay)")
                        .multilineTextAlignment(.leading)
                        .fontWeight(.semibold)
                    Text("\(dayWeather.day) \(humanMonth)")
                        .fontWeight(.medium)
                }
            }
            .frame(maxWidth: 120,maxHeight: 80)
            Spacer()
                .frame(maxWidth: 30)
            VStack(alignment: .leading) {
                Text(humanInfo.description)
                    .font(.callout)
                    .fontWeight(.medium)
                Spacer()
                Text("Temperatures ºC")
                    .font(.caption)
                    .fontWeight(.medium)
                HStack(alignment: .top) {
                    ForEach(keys.indices) {index in
                        VStack {
                            Text("\(keys[index])h")
                                .font(.caption2)
                            Text( String(format: "%.0f",dict[keys[index]]!.main.temp) )
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
        let weatherM: WeatherModel = WeatherModel.makePreviewData()
        let weatherDataM : [WeatherDataModel] = weatherM.list
        let daysWeather: [DayWeather] = weatherM.makeIOrderedWeatherDataByDay(fiveDaysData: weatherDataM)
        
        WeatherRowView(dayWeather: daysWeather[1])
            .previewLayout(.sizeThatFits)
    }
}
