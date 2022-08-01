//
//  Inspection.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 29/07/22.
//

import Foundation
import Combine
import SwiftUI

internal final class Inspection<V> {

    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
