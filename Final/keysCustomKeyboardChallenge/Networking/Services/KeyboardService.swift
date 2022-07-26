//
//  KeyboardContentService.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 24/07/22.
//

import UIKit

enum KeyboardService {
    case getContent
}

extension KeyboardService: EndpointTargetType {
    var baseURL: URL {
        return NetworkConstants.URLs.baseURL
    }

    var path: String {
        switch self {
        case .getContent:
            return "getContent"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .getContent:
            return .request
        }
    }
}
