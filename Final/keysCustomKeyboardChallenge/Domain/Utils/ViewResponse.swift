//
//  RequestResponse.swift
//  keyboard
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

enum ViewResponse<T: Equatable>: Equatable {
    static func == (lhs: ViewResponse<T>, rhs: ViewResponse<T>) -> Bool {
        switch (lhs, rhs) {
        case (.new, .new), (.loading, .loading):
            return true
        case (let .failure(lhsString), let .failure(rhsString)):
            return lhsString == rhsString
        case (let .success(lhsContent), let .success(rhsContent)):
            return lhsContent == rhsContent
        default:
            return false
        }
    }
    
    case new
    case loading
    case success(T)
    case failure(String)
}
