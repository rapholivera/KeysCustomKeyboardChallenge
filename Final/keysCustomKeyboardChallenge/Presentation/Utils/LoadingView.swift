//
//  LoadingView.swift
//  keyboard
//
//  Created by Raphael Oliveira on 25/07/22.
//

import SwiftUI

struct LoadingView: View {
    
    internal let inspection = Inspection<Self>() // 1.
    
    let loadingMessage: String
    var body: some View {
        VStack {
            ProgressView(loadingMessage)
                .progressViewStyle(CircularProgressViewStyle())
        }.padding()
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) } // 2.
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        let mockLoadingMessage: String = Localized.Default.SearchingContent
        LoadingView(loadingMessage: mockLoadingMessage)
    }
}
