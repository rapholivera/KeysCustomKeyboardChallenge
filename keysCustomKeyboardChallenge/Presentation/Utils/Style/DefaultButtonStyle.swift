//
//  DefaultButtonStyle.swift
//  keyboard
//
//  Created by Raphael Oliveira on 25/07/22.
//

import SwiftUI

struct DefaultButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        configuration
            .label
            .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : .white)
            .padding()
            .background(configuration.isPressed ? Color.accentColor.opacity(0.5) : .accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
//        VStack {
//            configuration
//                .label
//                .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : .white)
//                .padding()
//                .background(configuration.isPressed ? Color.accentColor.opacity(0.5) : .accentColor)
//                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
//                .shadow(color: .gray, radius: 2, x: 0, y: 2)
//                .scaleEffect(configuration.isPressed ? 0.95 : 1)
//            ProgressView(value: 25, total: 100)
//                .padding(.horizontal)
//        }
    }
}

struct ProgressButtonStyle: ButtonStyle {
    @State var currentProgress: Float = 50.0
    
    func makeBody(configuration: Configuration) -> some View {
        
        VStack {
            configuration
                .label
            ProgressView(value: 25, total: 100)
                .padding(.horizontal)
        }
    }
}
