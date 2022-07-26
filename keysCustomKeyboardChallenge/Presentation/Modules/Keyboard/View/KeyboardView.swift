//
//  RootView.swift
//  keyboard
//
//  Created by John Peterson on 5/10/22.
//

import SwiftUI

/// To be able to create a `ViewModel` interface here, we need to create this `type constraint` syntaxe
struct KeyboardView<ViewModel>: View where ViewModel: KeyboardViewModel {
    
    /// We can use a `ViewModel` interface to be conformed with a `Protocol Oriented Programming`
    /// An advantage of `protocols` in Swift is that objects can conform to multiple protocols. When writing an app this way, your code becomes more `modular`. Think of protocols as building blocks of functionality. When you add new functionality by conforming an object to a protocol, you don’t build a whole new object. `That’s time-consuming`. Instead, you add different building blocks until your object is ready.
    @ObservedObject var keyboardViewModel: ViewModel
    
    var body: some View {
        
        VStack {
            /// The `keyboardContentViewState` are responsible to make transitions between different states (loading, error, rendering the content)
            switch keyboardViewModel.keyboardContentViewState {
            case .new, .loading:
                /// If our project have an initial state before fetch content, we can handle it on `.new` state
                LoadingView(loadingMessage: Localized.Default.SearchingContent)
            case .success(let content):
                KeyboardContentView(keyboardContent: content) { content in
                    /// fired when user tap on keyboard content button
                    keyboardViewModel.clickSelectKeyboardContent(content: content)
                } clickContentFromMenu: { content, contentSelected in
                    /// fired when user tap on long pressed menu and select a keyboard content
                    keyboardViewModel.clickSelectKeyboardContentFromMenu(content: content, selectedContent: contentSelected)
                } clickExitInputMode: {
                    /// fired when user tap on exit input mode
                    keyboardViewModel.clickExitInputMode()
                }
            case .failure(let errorMessage):
                ErrorView(errorMessage: errorMessage) {
                    /// On `ErrorView` we can handle any uncessfull requests, and `redo the request if necessary
                    keyboardViewModel.fetchKeyboardContent()
                }
            }
        }.onAppear {
            /// fetch keyboard content only on `viewDidAppear` to avoid uncessesary requestes before render views
            keyboardViewModel.fetchKeyboardContent()
        }.frame(minHeight: 225)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDocumentProxy = DocumentProxyDummy()
        KeyboardFactory.build(documentProxy: mockDocumentProxy)
    }
    
    /// The `Dummy` class were created just to satisfy keyboard implementation, this approach will be more useful when writing tests
    private class DocumentProxyDummy: DocumentProxyCallbackProtocol {
        func insertText(_ text: String) {}
        func switchToNextInputMode() {}
    }
}
