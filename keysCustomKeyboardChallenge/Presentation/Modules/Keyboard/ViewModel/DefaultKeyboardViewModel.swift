//
//  DefaultKeyboardViewModel.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

/// `DocumentProxyCallbackProtocol` are responsible to callback keyboard content interaction,
/// assuming the callback cant be handled here, we must return it to a class inherited by `UIInputViewController`
protocol DocumentProxyCallbackProtocol {
    /// Inserts a character into the displayed text.
    func insertText(_ text: String)
    /// Switches to the next keyboard in the list of user-enabled keyboards.
    func switchToNextInputMode()
}

class DefaultKeyboardViewModel {
    
    private let useCase: GetContentUseCase
    private let documentProxyProtocol: DocumentProxyCallbackProtocol
    @Published private var keyboardState: ViewResponse<[KeyboardContent]> = .new
    
    init(useCase: GetContentUseCase, documentProxyCallback: DocumentProxyCallbackProtocol) {
        self.useCase = useCase
        self.documentProxyProtocol = documentProxyCallback
    }
}

extension DefaultKeyboardViewModel: KeyboardViewModel {
    /// `clickSelectKeyboardContentFromMenu` are responsible to handle user interaction on long press content menu content
    func clickSelectKeyboardContentFromMenu(content: KeyboardContent, selectedContent: String) {
        useCase.selectKeyboardContentFromMenu(content: content, selectedContent: selectedContent) { [weak self] inputContent in
            self?.documentProxyProtocol.insertText(inputContent)
        }
    }
    /// `clickSelectKeyboardContent` are responsible to handle user interaction on keyboard content button
    func clickSelectKeyboardContent(content: KeyboardContent) {
        useCase.selectKeyboardContent(content: content) { [weak self] inputContent in
            self?.documentProxyProtocol.insertText(inputContent)
        }
    }
    /// through`keyboardContentViewState` we can handle keyboard view states, in case of sucess response we can use `KeyboardContent` and build content buttons
    var keyboardContentViewState: ViewResponse<[KeyboardContent]> {
        return keyboardState
    }
    /// `fetchKeyboardContent` are responsible to make a request keyboard content directly, from user inteaction or view lifecycle
    func fetchKeyboardContent() {
        useCase.getContent()
            .assign(to: &$keyboardState)
    }
    /// Exit current keyboard and switches to the next keyboard in the list of user-enabled keyboards.
    func clickExitInputMode() {
        documentProxyProtocol.switchToNextInputMode()
    }
}
