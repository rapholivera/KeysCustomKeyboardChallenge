//
//  Array+Compare.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 30/07/22.
//

extension Array where Element: Comparable {
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}
