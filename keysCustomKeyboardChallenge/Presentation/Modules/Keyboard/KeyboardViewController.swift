//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by John Peterson on 5/10/22.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Instantiate and render our SwiftUI RootView
         
         Tip - the built in method `advanceToNextInput` exits our keyboard and takes
         the user to the next
         */
        
        setup(with: KeyboardFactory.build(documentProxy: self))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
}

extension KeyboardViewController: DocumentProxyCallbackProtocol {
    /// Inserts a character into the displayed text.
    func insertText(_ text: String) {
        clearInputText()
        textDocumentProxy.insertText(text)
    }
    /// Switches to the next keyboard in the list of user-enabled keyboards.
    func switchToNextInputMode() {
        advanceToNextInputMode()
    }
    /// Responsible to clear all the text that the UITextDocumentProxy object can access in the textfield before the cursor position
    private func clearInputText() {
        if let word:String = self.textDocumentProxy.documentContextBeforeInput {
            for _: Int in 0 ..< word.count {
                self.textDocumentProxy.deleteBackward()
            }
        }
    }
}

// MARK: - Custom Helpers for rendering SwiftUI (Don't worry about this)

extension KeyboardViewController {
    func setup<Content: View>(with view: Content) {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        let controller = KeyboardHostingController(rootView: view)
        controller.add(to: self)
    }
}

public class KeyboardHostingController<Content: View>: UIHostingController<Content> {
    func add(to controller: KeyboardViewController) {
        controller.addChild(self)
        controller.view.addSubview(view)
        didMove(toParent: controller)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
    }
}
