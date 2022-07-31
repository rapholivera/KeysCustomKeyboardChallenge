//
//  DefaultKeyboardViewModel.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit
import Combine

/// `DocumentProxyCallbackProtocol` are responsible to callback keyboard content interaction,
/// assuming the callback cant be handled here, we must return it to a class inherited by `UIInputViewController`
protocol DocumentProxyCallbackProtocol {
    /// Inserts a character into the displayed text.
    func insertText(_ text: String)
    /// Switches to the next keyboard in the list of user-enabled keyboards.
    func switchToNextInputMode()
}

class DefaultKeyboardViewModel: ObservableObject {
    
    private let useCase: GetContentUseCase
    private let documentProxyProtocol: DocumentProxyCallbackProtocol
    private let reloadContentSubject = PassthroughSubject<Void, Never>()
    
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
    var keyboardContentViewState: AnyPublisher<ViewResponse<[KeyboardContent]>, Never> {
        return reloadContentSubject
            .flatMap({ () -> AnyPublisher<ViewResponse<[KeyboardContent]>, Never> in
                print("FLAT MAP")
                return self.useCase.getContent().eraseToAnyPublisher()
            }).eraseToAnyPublisher()
    }
    /// `fetchKeyboardContent` are responsible to make a request keyboard content directly, from user inteaction or view lifecycle
    func fetchKeyboardContent() {
        print("SEND SUBJECT")
        reloadContentSubject.send(())
    }
    /// Exit current keyboard and switches to the next keyboard in the list of user-enabled keyboards.
    func clickExitInputMode() {
        documentProxyProtocol.switchToNextInputMode()
    }
}
