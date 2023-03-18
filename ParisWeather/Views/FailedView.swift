//
//  FailedView.swift
//  ParisWeather
//
//  Created by Cedrik on 18/03/2023.
//

import SwiftUI

struct FailedView: View {
    let isReloadButtonDisplayable: Bool
    @Binding var loadingState: LoadingState

    var body: some View {
        VStack {
            Spacer()
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

//struct FailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FailedView()
//    }
//}
