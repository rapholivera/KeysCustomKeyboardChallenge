//
//  KeyboardFactory.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

class KeyboardFactory {
    // MARK: - Life Cycle
    class func build() -> KeyboardView<DefaultKeyboardViewModel> {
        let viewModel = DefaultKeyboardViewModel()
        return KeyboardView(keyboardViewModel: viewModel)
    }
}
