//
//  KeyboardRepository.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit
import Combine

protocol KeyboardRepository {
    /// Fetch keyboard content from api
    func getContent() -> AnyPublisher<KeyboardContentResponse, HTTPError>
}
