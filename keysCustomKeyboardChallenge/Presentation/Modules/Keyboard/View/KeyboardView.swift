//
//  RootView.swift
//  keyboard
//
//  Created by John Peterson on 5/10/22.
//

import SwiftUI

struct KeyboardView<ViewModel>: View where ViewModel: KeyboardViewModel {
    
    @ObservedObject var keyboardViewModel: ViewModel
    
    var body: some View {
        
        VStack {
            switch keyboardViewModel.keyboardContentViewState {
            case .new:
                WelcomeView()
            case .loading:
                LoadingView(loadingMessage: "Fetching keyboard content...")
            case .success(let content):
                KeyboardContentView(keyboardContent: content)
            case .failure(let errorMessage):
                ErrorView(errorMessage: errorMessage) {
                    keyboardViewModel.fetchKeyboardContent()
                }
            }
        }.frame(minHeight: 240)
    }
}

//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockDocumentProxy = MockDocumentProxy()
//        KeyboardFactory.build(documentProxy: mockDocumentProxy)
//    }
//}
