//
//  KeyboardDataRepository.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit
import Combine

class KeyboardDataRepository {
    private var engine: NetworkEngineRouter<KeyboardService> {
        return NetworkEngineRouter<KeyboardService>()
    }
}

extension KeyboardDataRepository: KeyboardRepository {
    func getContent() -> AnyPublisher<[KeyboardContent], Error> {
        return getContentKeyboard().map { kContent in
            return kContent.content
        }.eraseToAnyPublisher()
    }
    
    private func getContentKeyboard() -> AnyPublisher<KeyboardContentResponse, Error> {
        return engine.request(target: .getContent)
    }
}
