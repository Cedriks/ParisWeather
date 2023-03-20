//
//  FailedView.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import SwiftUI

struct FailedView: View {
    let isReloadButtonDisplayable: Bool
    var errorMessage: String?
    @Binding var loadingState: LoadingState

    var body: some View {
        VStack {
            Spacer()
                Text(errorMessage!)
            Text("Please try later")
            Spacer()
            if isReloadButtonDisplayable {
                Button("Reload") {
                    loadingState = .loading
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
    }
}
