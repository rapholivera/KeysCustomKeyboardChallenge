//
//  RequestResponse.swift
//  keyboard
//
//  Created by Raphael Oliveira on 25/07/22.
//

import UIKit

enum ViewResponse<T> {
    case new
    case loading
    case success(T)
    case failure(String)
}
