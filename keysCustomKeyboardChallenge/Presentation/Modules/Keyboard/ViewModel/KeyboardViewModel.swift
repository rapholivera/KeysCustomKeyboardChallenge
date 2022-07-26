//
//  KeyboardViewModel.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

protocol KeyboardViewModel: ObservableObject {
    /// properties
    var keyboardContentViewState: ViewResponse<[KeyboardContent]> { get }
    /// functions
    func fetchKeyboardContent()
    /// Exit current keyboard and switches to the next keyboard in the list of user-enabled keyboards.
    func clickSelectKeyboardContent(content: KeyboardContent)
    /// Exit current keyboard and switches to the next keyboard in the list of user-enabled keyboards.
    func clickSelectKeyboardContentFromMenu(content: KeyboardContent, selectedContent: String)
    /// Exit current keyboard and switches to the next keyboard in the list of user-enabled keyboards.
    func clickExitInputMode()
}
