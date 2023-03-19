//
//  HomeView.swift
//  ParisWeather
//
//  Created by Cedrik on 17/03/2023.
//

import SwiftUI

// MARK: - View
struct HomeView: View {
    @StateObject var viewModel : ViewModel
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Weather.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Weather.city, ascending: true)]) var results :  FetchedResults<Weather>
    
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
                LoadingView(results: results, viewModel: viewModel)
                        .task {
                            await viewModel.getWeather(context: context)
                        }
            case .failed:
                FailedView(isReloadButtonDisplayable: true,
                           loadingState: $viewModel.loadingState)
            }
        }
    }
}
// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeView.ViewModel(cityName: "Paris"))
    }
}
