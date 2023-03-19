//
//  LoadingView.swift
//  ParisWeather
//
//  Created by Cedrik on 18/03/2023.
//

import SwiftUI

struct LoadingView: View {
    var results: FetchedResults<Weather>
    var viewModel : HomeView.ViewModel
    var body: some View {
        if (results.isEmpty == true) {
            VStack {
                ProgressView()
                Text("Loading")
            }
        } else {
            VStack {
                
            }.task {
                viewModel.loadingState = .loaded
            }
        }
    }
}

//struct LoadingView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingView()
//    }
//}
