//
//  KeyboardContentView.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import SwiftUI

struct KeyboardContentButtonView: View {
    
    let content: KeyboardContent
    let action: () -> Void

    var body: some View {
        Button(content.displayText.capitalized, action: action)
            .foregroundColor(.white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(8)
    }
}
