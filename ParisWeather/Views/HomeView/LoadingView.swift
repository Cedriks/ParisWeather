//
//  LoadingView.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
            VStack {
                ProgressView()
                Text("Loading")
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
