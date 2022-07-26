//
//  RetryButtonStyle.swift
//  keyboard
//
//  Created by Raphael Oliveira on 26/07/22.
//

import SwiftUI

struct RetryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : .white)
            .padding()
            .background(configuration.isPressed ? Color.red.opacity(0.5) : .red)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}
