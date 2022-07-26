//
//  KeyboardFactory.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

class KeyboardFactory {
    // MARK: - Life Cycle
    class func build(documentProxy: DocumentProxyCallbackProtocol) -> KeyboardView<DefaultKeyboardViewModel> {
        let useCase = DefaultGetContentUseCase(repository: KeyboardDataRepository())
        let viewModel = DefaultKeyboardViewModel(useCase: useCase, documentProxyCallback: documentProxy)
        return KeyboardView(keyboardViewModel: viewModel)
    }
}
