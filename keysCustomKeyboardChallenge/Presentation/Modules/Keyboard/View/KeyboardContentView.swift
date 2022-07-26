//
//  KeyboardContentView.swift
//  keyboard
//
//  Created by Raphael Oliveira on 26/07/22.
//

import SwiftUI

struct KeyboardContentView: View {
    let keyboardContent: [KeyboardContent]
    var body: some View {

        VStack {            
            HStack {
                ForEach(keyboardContent, id: \.self) {
                    Button($0.displayText.capitalized) {
                        print("selected content")
                    }.buttonStyle(DefaultButtonStyle())
                }
            }.padding(.vertical, 40)
            
            HStack {
                Button("Sair") {
                    print("selected content")
                }.buttonStyle(DefaultButtonStyle())
                Spacer()
            }
        }.padding()
    }
}

struct KeyboardContentView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardContentView(keyboardContent: [])
    }
}
