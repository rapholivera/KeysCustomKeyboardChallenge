//
//  KeyboardDataRepository.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit
import Combine

class KeyboardDataRepository: KeyboardRepository {
    
    private var engine: NetworkEngineRouter<KeyboardService> {
        return NetworkEngineRouter<KeyboardService>()
    }
    
    func getContent() -> AnyPublisher<[KeyboardContent], Error> {
        return engine.request(target: .getContent)
    }
}
