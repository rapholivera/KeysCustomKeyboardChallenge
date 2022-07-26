//
//  NetworkConstants.swift
//  keysCustomKeyboardChallenge
//
//  Created by Raphael Oliveira on 23/07/22.
//

import UIKit

/**
 `NetworkConstants` are responsable to manage different endpoints using compiler variables,
 these compiler variables can be `Production`, `Development`, `Staging`, or anyelse we have in our development process
 */
struct NetworkConstants {
    
    struct URLs {

        static var baseURL: URL {

            /**
             Using targets we can handle different endpoints, each should have an specific compiler variable,
             that way we don't need to change environments manually, but just execute the specific target
             we will always use `baseURL` but with different content base on target chosen
             
             #if PRODUCTION
             let base = String("production-url")
             #elseif DEVELOPMENT
             let base = String("development-url")
             #else
             let base = String("staging-url")
             #endif
             
             */
            
            let base = String("https://frontend-coding-challenge-api.herokuapp.com/")

            guard let url = URL(string: base) else {
                fatalError("Error to convert string url to URL")
            }
            return url
        }
    }
}
