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
}
