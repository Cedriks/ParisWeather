//
//  HomeView.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel : ViewModel
    
    // MARK: - View
    var body: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .loaded:
                HomeViewLoaded(weather: viewModel.weather!)
                    .navigationTitle("Météo")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem (placement: .navigationBarTrailing) {
                            Button {
                                viewModel.clearWeather()
                            } label: {
                                Image(systemName: "arrow.clockwise.circle")
                            }
                        }
                    }
            case .loading:
               LoadingView()
                    .task {
                        await viewModel.getWeather()
                    }
            case .failed:
                FailedView(isReloadButtonDisplayable: true,
                           loadingState: $viewModel.loadingState)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeView.ViewModel(cityName: "Paris"))
    }
}
