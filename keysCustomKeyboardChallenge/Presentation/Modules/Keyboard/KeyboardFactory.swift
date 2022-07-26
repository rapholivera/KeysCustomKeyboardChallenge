//
//  KeyboardFactory.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

class KeyboardFactory {
    // MARK: - Life Cycle
    class func build(documentProxy: UITextDocumentProxy) -> KeyboardView<DefaultKeyboardViewModel> {
        let repository = KeyboardDataRepository()
        let viewModel = DefaultKeyboardViewModel(repository: repository, documentProxy: documentProxy)
        return KeyboardView(keyboardViewModel: viewModel)
    }
}
