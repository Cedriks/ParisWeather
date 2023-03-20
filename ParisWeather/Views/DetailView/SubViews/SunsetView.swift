//
//  SunsetView.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct SunsetView: View {
    let makeSunset: UnitDescription
    var body: some View {
        VStack{
            Image(systemName: makeSunset.unit)
            Text(makeSunset.value)
                .font(.caption)
        }
    }
}

