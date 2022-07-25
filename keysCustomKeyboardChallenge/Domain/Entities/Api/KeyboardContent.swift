//
//  KeyboardContent.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

//{"id":"1","displayText":"greetings","content":["hey","what's up?","how's it going?"]}

struct KeyboardContent: Hashable, Decodable, Encodable {
    let id: String
    let displayText: String
    let content: [String]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(displayText, forKey: .displayText)
        try container.encode(content, forKey: .content)
    }
}
