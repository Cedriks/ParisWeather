//
//  TemperatureView.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct TemperatureView: View {
    @StateObject var viewModel : TemperatureViewModel
    
    var body: some View {
        HStack(alignment: .bottom) {
            HStack(alignment: .top) {
                Text(viewModel.makeTemperature.value ?? "")
                Text(viewModel.makeTemperature.unit ?? "")
                    .font(.caption)
            }
            VStack{
                HStack{
                    Text(viewModel.makeMaxTempString())
                        .font(.caption)
                        .fontWeight(.light)
                }
                HStack{
                    Text(viewModel.makeMinTempString())
                        .font(.caption)
                        .fontWeight(.light)
                }
            }
        }
    }
}


struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView()
    }
}
