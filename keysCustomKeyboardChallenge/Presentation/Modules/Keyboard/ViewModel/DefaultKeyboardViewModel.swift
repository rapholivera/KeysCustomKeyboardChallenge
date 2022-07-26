//
//  DefaultKeyboardViewModel.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

class DefaultKeyboardViewModel {
    
    private let repository: KeyboardRepository
    private let documentProxy: UITextDocumentProxy
    @Published private var keyboardState: ViewResponse<[KeyboardContent]> = .new
    
    init(repository: KeyboardRepository, documentProxy: UITextDocumentProxy) {
        self.repository = repository
        self.documentProxy = documentProxy
        self.fetchKeyboardContent()
    }
}

extension DefaultKeyboardViewModel: KeyboardViewModel {
    
    var keyboardContentViewState: ViewResponse<[KeyboardContent]> {
        return keyboardState
    }
    
    func fetchKeyboardContent() {
        repository.getContent()
            .assign(to: &$keyboardState)
    }
}
