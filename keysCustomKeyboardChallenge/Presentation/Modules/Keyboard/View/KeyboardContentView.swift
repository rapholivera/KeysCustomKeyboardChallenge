//
//  KeyboardContentView.swift
//  keyboard
//
//  Created by Raphael Oliveira on 26/07/22.
//

import SwiftUI

struct KeyboardContentView: View {
    
    let keyboardContent: [KeyboardContent]
    var clickContent: ((_ content: KeyboardContent) -> ())?
    var clickContentFromMenu: ((_ content: KeyboardContent, _ contentSelected: String) -> ())?
    let clickExitInputMode: (() -> Void)?
    
    var body: some View {
        
        VStack {
            HStack {
                ForEach(keyboardContent, id: \.self) { content in
                    
                    Button(content.displayText.capitalized) {
                        clickContent?(content)
                    }.buttonStyle(DefaultButtonStyle())
                        .contextMenu {
                            ForEach(content.content, id: \.self) { contentText in
                                Button {
                                    clickContentFromMenu?(content, contentText)
                                } label: {
                                    Label(contentText.capitalized, systemImage: "message")
                                }
                            }
                        }
                }
            }.padding(.vertical, 40)
            
            HStack {
                Button("Sair") {
                    clickExitInputMode?()
                }.buttonStyle(DefaultButtonStyle())
                Spacer()
            }
        }.padding()
    }
}

struct KeyboardContentView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardContentView(keyboardContent: [], clickExitInputMode: nil)
    }
}
