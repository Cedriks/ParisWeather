//
//  SunriseView.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct SunriseView: View {
    let makeSunrise: UnitDescription
    var body: some View {
        VStack{
            Image(systemName: makeSunrise.unit)
            Text(makeSunrise.value)
                .font(.caption)
        }
    }
}


