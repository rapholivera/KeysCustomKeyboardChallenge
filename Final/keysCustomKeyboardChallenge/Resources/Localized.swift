//
//  Localized.swift
//  keyboard
//
//  Created by Raphael Oliveira on 26/07/22.
//

import Foundation

final class Localized {
    static var bundle: Bundle {
        Bundle(for: Localized.self)
    }
}

extension Localized {

    enum Default {
        /// The `Default.strings` should have all base strings in app
        static private var table: String { "Default" }
        /// `Cancel` action used in alerts and confirmations
        static var SearchingContent: String {
            return NSLocalizedString("searchingKeyboardContent", tableName: table, bundle: bundle, comment: "")
        }
        /// `Exit` action used to close a content or move back to other module
        static var Exit: String {
            return NSLocalizedString("exit", tableName: table, bundle: bundle, comment: "")
        }
        /// `Retry` action used to redo some task
        static var Retry: String {
            return NSLocalizedString("retry", tableName: table, bundle: bundle, comment: "")
        }
        /// `GenericErrorMessage` is a generic error message for unexpected situations
        static var GenericErrorMessage: String {
            return NSLocalizedString("genericErrorMessage", tableName: table, bundle: bundle, comment: "")
        }
    }
}
