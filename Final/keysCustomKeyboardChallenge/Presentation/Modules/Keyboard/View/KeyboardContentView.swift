//
//  KeyboardContentView.swift
//  keyboard
//
//  Created by Raphael Oliveira on 26/07/22.
//

import SwiftUI

struct KeyboardContentView: View {
    
    /// `keyboardContent`is an array of keyboard contents requested from api, and we use it to build buttons
    let keyboardContent: [KeyboardContent]
    /// `clickContent` is a allback indicating that user clicked in some content button. `KeyboardContent` are passed itself as paremeter to get next content available inside `KeyboardContent` and insert it on keyboar inut text
    var clickContent: ((_ content: KeyboardContent) -> ())?
    /// `clickContentFromMenu` is a callback indicating that user selected a content from long press menu, `KeyboardContent` and `contentSelected` are passed itself as paremeter to determine what content from witch `KeyboardContent` has been selected
    var clickContentFromMenu: ((_ content: KeyboardContent, _ contentSelected: String) -> ())?
    /// `clickExitInputMode` is a callback indicating that user clicked on `exit`
    let clickExitInputMode: (() -> Void)?
    
    var body: some View {
        
        VStack {
            HStack {
                /// iterate `keyboardContent` and create a styled button for each record in array
                ForEach(keyboardContent, id: \.self) { content in
                    Button(content.displayText.capitalized) {
                        clickContent?(content)
                    }.buttonStyle(DefaultButtonStyle())
                    /// to make log presse menu possible, we can just create a `contextMenu` for each button and define some options for it based on contents to follow business requirements
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
                Button(Localized.Default.Exit) {
                    clickExitInputMode?()
                }.buttonStyle(DefaultButtonStyle())
                /// Creating a `Spacer` inside `HStack` and after exit button is important to align exit button on leading and fit all the right content
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
