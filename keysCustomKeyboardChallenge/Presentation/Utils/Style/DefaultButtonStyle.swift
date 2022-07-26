//
//  DefaultButtonStyle.swift
//  keyboard
//
//  Created by Raphael Oliveira on 25/07/22.
//

import SwiftUI

struct DefaultButtonStyle: ButtonStyle {
    
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        
        let textColor: Color = (colorScheme == .dark ? .white : .black)
        let backgroundColor: Color = (colorScheme == .dark ? Color.gray.opacity(0.5) : .white)
        
        configuration
            .label
            .foregroundColor(configuration.isPressed ? textColor.opacity(0.5) : textColor)
            .padding()
            .background(configuration.isPressed ? backgroundColor.opacity(0.5) : backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
            .shadow(radius: 2, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
