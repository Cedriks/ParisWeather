//
//  DetailRowView.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct DetailRowView: View {
    var unitDesc: UnitDescription?
    
    var body: some View {
        if let unit = unitDesc {
            HStack {
                Text(unit.name)
                Spacer()
                HStack(alignment: .bottom) {
                    Text(unit.value)
                    Text(unit.unit)
                        .font(.caption2)
                }
            }
            .padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}
struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        let unit = UnitDescription(name: "Temperature", value: "\(15)", unit: "ºC")
        DetailRowView(unitDesc: UnitDescription(name: unit.name, value: unit.value, unit: unit.unit))
            .previewLayout(.sizeThatFits)
    }
}
