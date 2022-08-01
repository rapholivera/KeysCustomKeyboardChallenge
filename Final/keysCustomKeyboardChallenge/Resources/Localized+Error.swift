//
//  Localized+Error.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 30/07/22.
//

import UIKit

extension Localized {

    enum Error {
        /// The `Default.strings` should have all base strings in app
        static private var table: String { "Error" }
        /// `Random Error` action used in alerts and confirmations
        static var RandomError: String {
            return NSLocalizedString("randomError", tableName: table, bundle: bundle, comment: "")
        }
    }
}

