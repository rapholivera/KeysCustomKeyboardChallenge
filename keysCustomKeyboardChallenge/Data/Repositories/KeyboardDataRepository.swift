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
    func getContent() -> AnyPublisher<ViewResponse<[KeyboardContent]>, Never> {
        return getContentKeyboard()
            .map { .success($0.content) }
            .catch { error in Just(.failure(error.localizedDescription)) }
            .receive(on: RunLoop.main)
            .prepend(.loading)
            .eraseToAnyPublisher()
    }
    
    private func getContentKeyboard() -> AnyPublisher<KeyboardContentResponse, Error> {
        return engine.request(target: .getContent)
    }
}
