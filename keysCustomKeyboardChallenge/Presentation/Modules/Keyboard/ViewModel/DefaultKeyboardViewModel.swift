//
//  DefaultKeyboardViewModel.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

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
        self.fetchKeyboardContent()
    }
}

extension DefaultKeyboardViewModel: KeyboardViewModel {
    func clickSelectKeyboardContentFromMenu(content: KeyboardContent, selectedContent: String) {
        useCase.selectKeyboardContentFromMenu(content: content, selectedContent: selectedContent) { [weak self] inputContent in
            self?.documentProxyProtocol.insertText(inputContent)
        }
    }
    func clickSelectKeyboardContent(content: KeyboardContent) {
        useCase.selectKeyboardContent(content: content) { [weak self] inputContent in
            self?.documentProxyProtocol.insertText(inputContent)
        }
    }
    var keyboardContentViewState: ViewResponse<[KeyboardContent]> {
        return keyboardState
    }
    func fetchKeyboardContent() {
        useCase.getContent()
            .assign(to: &$keyboardState)
    }
    /// Exit current keyboard and switches to the next keyboard in the list of user-enabled keyboards.
    func clickExitInputMode() {
        documentProxyProtocol.switchToNextInputMode()
    }
}
