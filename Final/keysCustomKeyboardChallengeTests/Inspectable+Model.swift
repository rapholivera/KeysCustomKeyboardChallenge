//
//  Inspectable+Model.swift
//  keysCustomKeyboardChallengeTests
//
//  Created by Raphael Oliveira on 29/07/22.
//

import Foundation
import ViewInspector

@testable import keysCustomKeyboardChallenge

extension Inspection: InspectionEmissary { }
extension KeyboardView: Inspectable { }
extension LoadingView: Inspectable { }
extension KeyboardContentView: Inspectable { }
extension ErrorView: Inspectable { }
extension BaseView: Inspectable {}
