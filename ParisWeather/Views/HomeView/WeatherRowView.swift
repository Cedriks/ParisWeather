//
//  WeatherRowView.swift
//  ParisWeather
//
//  Created by Cedrik on 18/03/2023.
//

import SwiftUI

struct WeatherRowView: View {
    //    let weatherData: WeatherData
    //    var body: some View {
    //        HStack {
    //            Text(Date().makeReadableDate(dt: weatherData.dt).toString())
    //            Text(String(format: "%.0f", weatherData.main.temp) + " C")
    //        }
    //    }
    
    var body: some View {
        HStack {
            Image(systemName: "sun.min")
                .resizable()
                .frame(width: 60, height: 60)
                .padding()
            VStack(alignment: .leading) {
                Text("Lundi 12 Mars")
                    .font(.title3)
                    .fontWeight(.medium)
                HStack {
                    VStack {
                        Text("01H")
                            .font(.caption2)
                        Text("12")
                            .font(.headline)
                    }
                    VStack {
                        Text("04H")
                            .font(.caption2)
                        Text("13")
                            .font(.headline)
                    }
                    VStack {
                        Text("07H")
                            .font(.caption2)
                        Text("14")
                            .font(.headline)
                    }
                    VStack {
                        Text("10H")
                            .font(.caption2)
                        Text("15")
                            .font(.headline)
                    }
                    VStack {
                        Text("13H")
                            .font(.caption2)
                        Text("16")
                            .font(.headline)
                    }
                    VStack {
                        Text("16H")
                            .font(.caption2)
                        Text("14")
                            .font(.headline)
                    }
                    VStack {
                        Text("19H")
                            .font(.caption2)
                        Text("13")
                            .font(.headline)
                    }
                    VStack {
                        Text("22H")
                            .font(.caption2)
                        Text("12")
                            .font(.headline)
                    }
                }
            }
            .padding(.trailing)
            .frame(height: 60)
        }
    }
}


struct WeatherRowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRowView()
            .previewLayout(.sizeThatFits)
    }
}
