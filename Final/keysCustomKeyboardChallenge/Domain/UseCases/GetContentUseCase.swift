//
//  GetContentUseCase.swift
//  keyboard
//
//  Created by Raphael Oliveira on 26/07/22.
//

import UIKit
import Combine

protocol GetContentUseCase {
    /// Responsible to fetch keyboard content from api and transform in a object readable by keyboardview
    func getContent() -> AnyPublisher<ViewResponse<[KeyboardContent]>, Never>
    /// Responsible to handle the keyboard content selected by user from vontent buttons and return right content to be displayed in textfield
    func selectKeyboardContent(content: KeyboardContent, inputTextResponse: @escaping (String) -> Void)
    /// Responsible to handle the keyboard content selected by user from long press menu and return right content to be displayed in textfield
    func selectKeyboardContentFromMenu(content: KeyboardContent, selectedContent: String, inputTextResponse: @escaping (String) -> Void)
}
/**
 `GetContentUseCase` are responsible to handle business requirements and determine where system can find correctly any information it needs,
 that way if in a future we need to `change`, `remove` or `import` any new `frameworks`, this process will be smoothly for the entire application including tests
 */
class DefaultGetContentUseCase {
    let repository: KeyboardRepository
    /// current selected index of keyboard content, initially sould be the first index
    private var selectedContentIndex: Int = 0
    /// current selected keyboard content, initially sould be null
    private var selectedKeyboardContent: KeyboardContent? = nil

    init(repository: KeyboardRepository) {
        self.repository = repository
    }
}

extension DefaultGetContentUseCase: GetContentUseCase {
    
    /// Responsible to fetch keyboard content from api and transform in a object readable by keyboardview
    func getContent() -> AnyPublisher<ViewResponse<[KeyboardContent]>, Never> {
        return repository.getContent()
            .map { .success($0.content) }
            .catch { error in Just(.failure(error.localizedDescription)) }
            .receive(on: RunLoop.main)
            .prepend(.loading)
            .eraseToAnyPublisher()
    }
    /// Responsible to handle the keyboard content selected by user from long press menu and return right content to be displayed in textfield
    func selectKeyboardContentFromMenu(content: KeyboardContent, selectedContent: String, inputTextResponse: @escaping (String) -> Void) {
        if let index = content.content.firstIndex(of: selectedContent) {
            selectedContentIndex = index
            selectedKeyboardContent = content
            inputTextResponse(selectedContent)
        }
    }
    /// Responsible to handle the keyboard content selected by user from vontent buttons and return right content to be displayed in textfield
    func selectKeyboardContent(content: KeyboardContent, inputTextResponse: @escaping (String) -> Void) {
        
        /// if user had selected a content that had previuos selected, this method will check for the next content from the array and return the right one
        if let currentSelectedContent = selectedKeyboardContent, currentSelectedContent == content {
            let intendedIndex: Int = selectedContentIndex + 1
            
            /// if user reach last content from the array of contents, so this method will return the first one
            if currentSelectedContent.content.count > intendedIndex {
                selectedContentIndex = intendedIndex
                inputTextResponse(content.content[intendedIndex])
            } else {
                selectedContentIndex = 0
                inputTextResponse(content.content[selectedContentIndex])
            }
            
        /// if user select a content different that was selected before, so this method will return the first content of this new one
        } else {
            selectedContentIndex = 0
            selectedKeyboardContent = content
            inputTextResponse(content.content[selectedContentIndex])
        }
    }
}
