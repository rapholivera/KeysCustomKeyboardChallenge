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
    func getContent() -> AnyPublisher<KeyboardContentResponse, Error> {
        return engine.request(target: .getContent)
    }
}
