//
//  HomeView.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import SwiftUI

// MARK: - View
struct HomeView: View {
    @StateObject var viewModel : HomeViewModel
    
    var body: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .loaded:
                HomeViewLoaded(weather: viewModel.weather!,
                               fiveDayWeather: viewModel.fiveDayWeather)
                .navigationTitle("Weather")
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
                FailedView(isReloadButtonDisplayable: true, errorMessage: viewModel.errorMessage ?? "Error",
                           loadingState: $viewModel.loadingState)
            }
        }
    }
}
// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(cityName: "Paris"))
    }
}
