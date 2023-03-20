//
//  WeatherRowView.swift
//  ParisWeather
//
//  Created by Cedrik on 18/03/2023.
//

import SwiftUI

struct WeatherRowView: View {
    var dayWeather : DayWeather
    
    var body: some View {
        let dict = dayWeather.hours
        let keys = dict.map{$0.key}.sorted(by: <)
        let humanDay = dayWeather.date.getHumanReadableDayString()
        let humanMonth = dayWeather.date.getHumanReadableMonthString()
        
        HStack {
            Text("\(humanDay) \(dayWeather.day) \(humanMonth)")
                .fontWeight(.medium)
            Spacer()
            HStack(alignment: .top) {
                ForEach(keys.indices) {index in
                    VStack {
                        Text("\(keys[index])")
                            .font(.caption2)
                        Text( String(format: "%.0f",dict[keys[index]]!.main.temp))
                            .font(.footnote)
                    }.frame(width: 20)
                }
            }
        }
        .frame(height: 60)
    }
}


struct WeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherM: WeatherModel = WeatherModel.makePreviewData()
        let weatherDataM : [WeatherDataModel] = weatherM.list
        let daysWeather: [DayWeather] = weatherM.makeIOrderedWeatherDataByDay(fiveDaysData: weatherDataM)
        
        WeatherRowView(dayWeather: daysWeather.first!)
            .previewLayout(.sizeThatFits)
    }
}
