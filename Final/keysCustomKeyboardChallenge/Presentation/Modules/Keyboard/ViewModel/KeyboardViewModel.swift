//
//  KeyboardViewModel.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit
import Combine

protocol KeyboardViewModel: ObservableObject {
    /// through`keyboardContentViewState` we can handle keyboard view states, in case of sucess response we can use `KeyboardContent` and build content buttons
    var keyboardContentViewState: AnyPublisher<ViewResponse<[KeyboardContent]>, Never> { get }
    /// `fetchKeyboardContent` are responsible to make a request keyboard content directly, from user inteaction or view lifecycle
    func fetchKeyboardContent()
    /// `clickSelectKeyboardContent` are responsible to handle user interaction on keyboard content button
    func clickSelectKeyboardContent(content: KeyboardContent)
    /// `clickSelectKeyboardContentFromMenu` are responsible to handle user interaction on long press content menu content
    func clickSelectKeyboardContentFromMenu(content: KeyboardContent, selectedContent: String)
    /// Exit current keyboard and switches to the next keyboard in the list of user-enabled keyboards.
    func clickExitInputMode()
}
