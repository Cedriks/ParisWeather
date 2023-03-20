//
//  DetailRowView.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct DetailRowView: View {
    var unitDesc: UnitDescription
    
    var body: some View {
        HStack {
            Text(unitDesc.name)
            Spacer()
            HStack(alignment: .bottom) {
                Text(unitDesc.value)
                Text(unitDesc.unit)
                    .font(.caption2)
            }
        }
        .padding(.horizontal)
    }
}
struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        let unit = UnitDescription(name: "Temperature", value: "\(15)", unit: "ºC")
        DetailRowView(unitDesc: UnitDescription(name: unit.name, value: unit.value, unit: unit.unit))
            .previewLayout(.sizeThatFits)
    }
}
