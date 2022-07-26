//
//  ErrorView.swift
//  keyboard
//
//  Created by Raphael Oliveira on 25/07/22.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let actionBlock: (() -> Void)?
    
    var body: some View {
        VStack {
            Text(errorMessage)
            Button(Localized.Default.Retry) {
                actionBlock?()
            }.buttonStyle(RetryButtonStyle())
        }.padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let mockErrorMessage: String = Localized.Default.GenericErrorMessage
        ErrorView(errorMessage: mockErrorMessage) { }
    }
}
