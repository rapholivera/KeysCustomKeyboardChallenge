//
//  LoadingView.swift
//  keyboard
//
//  Created by Raphael Oliveira on 25/07/22.
//

import SwiftUI

struct LoadingView: View {
    let loadingMessage: String
    var body: some View {
        VStack {
            ProgressView(loadingMessage)
                .progressViewStyle(CircularProgressViewStyle())
        }.padding()   
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        let mockLoadingMessage: String = Localized.Default.SearchingContent
        LoadingView(loadingMessage: mockLoadingMessage)
    }
}
