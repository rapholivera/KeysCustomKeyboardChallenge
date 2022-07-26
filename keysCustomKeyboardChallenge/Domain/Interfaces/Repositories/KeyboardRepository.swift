//
//  KeyboardRepository.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit
import Combine

protocol KeyboardRepository {
    func getContent() -> AnyPublisher<KeyboardContentResponse, Error>
}
