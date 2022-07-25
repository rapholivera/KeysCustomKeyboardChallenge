//
//  RootView.swift
//  keyboard
//
//  Created by John Peterson on 5/10/22.
//

import SwiftUI

struct KeyboardView<ViewModel>: View where ViewModel: KeyboardViewModel {
    
    @ObservedObject var keyboardViewModel: ViewModel
    
    var body: some View {
        
        HStack {
            ForEach(keyboardViewModel.content, id: \.self) {
                KeyboardContentButtonView(content: $0, action: {
                    print("selected content")
                })
            }
        }.padding()
        
        if keyboardViewModel.isLoadingContent {
            ProgressView("Discovering new Content...")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardFactory.build()
    }
}
