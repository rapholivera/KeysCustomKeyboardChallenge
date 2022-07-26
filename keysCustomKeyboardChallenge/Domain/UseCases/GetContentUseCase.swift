//
//  GetContentUseCase.swift
//  keyboard
//
//  Created by Raphael Oliveira on 26/07/22.
//

import UIKit
import Combine

protocol GetContentUseCase {
    func getContent() -> AnyPublisher<ViewResponse<[KeyboardContent]>, Never>
    func selectKeyboardContent(content: KeyboardContent, inputTextResponse: @escaping (String) -> Void)
    func selectKeyboardContentFromMenu(content: KeyboardContent, selectedContent: String, inputTextResponse: @escaping (String) -> Void)
}

class DefaultGetContentUseCase {
    let repository: KeyboardRepository
    private var selectedContentIndex: Int = 0
    private var selectedKeyboardContent: KeyboardContent? = nil

    init(repository: KeyboardRepository) {
        self.repository = repository
    }
}

extension DefaultGetContentUseCase: GetContentUseCase {
    
    func getContent() -> AnyPublisher<ViewResponse<[KeyboardContent]>, Never> {
        return repository.getContent()
            .map { .success($0.content) }
            .catch { error in Just(.failure(error.localizedDescription)) }
            .receive(on: RunLoop.main)
            .prepend(.loading)
            .eraseToAnyPublisher()
    }
    
    func selectKeyboardContentFromMenu(content: KeyboardContent, selectedContent: String, inputTextResponse: @escaping (String) -> Void) {
        if let index = content.content.firstIndex(of: selectedContent) {
            selectedContentIndex = index
            selectedKeyboardContent = content
            inputTextResponse(selectedContent)
        }
    }
    
    func selectKeyboardContent(content: KeyboardContent, inputTextResponse: @escaping (String) -> Void) {
        
        if let currentSelectedContent = selectedKeyboardContent, currentSelectedContent == content {
            let intendedIndex: Int = selectedContentIndex + 1
            
            if currentSelectedContent.content.count > intendedIndex {
                selectedContentIndex = intendedIndex
                inputTextResponse(content.content[intendedIndex])
            } else {
                selectedContentIndex = 0
                inputTextResponse(content.content[selectedContentIndex])
            }
            
        } else {
            selectedContentIndex = 0
            selectedKeyboardContent = content
            inputTextResponse(content.content[selectedContentIndex])
        }
    }
}
