//
//  HTTPLogger.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 24/07/22.
//

import UIKit

class HTTPLogger {
    static func log(request: URLRequest, response: URLResponse?, data: Data?) {

        #if DEBUG
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }

        let urlAsString = request.url?.absoluteString ?? ""

        var method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""

        if let httpStatus = response as? HTTPURLResponse {
            method += " [\(httpStatus.statusCode)]"
        }

        var logOutput = "\(method) \(urlAsString)\n\n"
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }

        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8), !bodyString.isEmpty {
            logOutput += "\n \(bodyString)"
        }

        if let data = data {
            logOutput += "\n \(String(data: data, encoding: .utf8)!)"
        }

        print(logOutput)
        #endif
    }

    static func log(response: URLResponse) {}
}
