//
//  DefaultKeyboardViewModel.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

class DefaultKeyboardViewModel {
    
    private let repository: KeyboardRepository
    @Published private var arrKeyboardContent = [KeyboardContent]()
    @Published private var isKeyboardLoadingContent: Bool = false
    
    init(repository: KeyboardRepository) {
        self.repository = repository
        self.fetchKeyboardContent()
    }
}

extension DefaultKeyboardViewModel: KeyboardViewModel {
    
    func fetchKeyboardContent() {
        repository.getContent()
        .compactMap({ $0 })
        .replaceError(with: [])
        .eraseToAnyPublisher()
        .receive(on: DispatchQueue.main)
        .handleEvents(receiveSubscription: { _ in
            self.isKeyboardLoadingContent = true
        }, receiveCompletion: { _ in
            self.isKeyboardLoadingContent = false
        })
        .assign(to: &$arrKeyboardContent)
    }
    
    var content: [KeyboardContent] {
        return arrKeyboardContent
    }
    
    var isLoadingContent: Bool {
        return isKeyboardLoadingContent
    }
}
