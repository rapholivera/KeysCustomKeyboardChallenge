//
//  EndpointTargetType.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 24/07/22.
//

import UIKit

protocol EndpointTargetType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}
