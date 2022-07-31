//
//  HTTPError.swift
//  keyboard
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

enum HTTPError: Error {
    /// Generic error received from server
    case randomError
}

extension HTTPError: LocalizedError {
    public var errorMessage: String {
        switch self {
        case .randomError:
            return Localized.Error.RandomError
        }
    }
}
