//
//  BaseView.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 28/07/22.
//

import SwiftUI

struct BaseView<Content: View>: View {
    let content: Content
    internal let inspection = Inspection<Self>() // 1.

    var body : some View {
        content
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) } // 2.
    }
}
