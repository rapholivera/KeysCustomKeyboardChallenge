//
//  DefaultKeyboardViewModel.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

class DefaultKeyboardViewModel: KeyboardViewModel {
    var content: [KeyboardContent] {
        return [KeyboardContent(id: "1", displayText: "greetings", content: ["hey","what's up?","how's it going?"]),
                KeyboardContent(id: "2", displayText: "greetings", content: ["hey","what's up?","how's it going?"]),
                KeyboardContent(id: "3", displayText: "greetings", content: ["hey","what's up?","how's it going?"])]
    }
    
    var isLoadingContent: Bool {
        return false
    }
}
