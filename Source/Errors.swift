//
//  Errors.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 10/25/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case stringSerialization(error: Error)
    case jsonSerialization(error: Error)
    case objectSerialization(reason: String)
    case invalidHMToken
    case incorrectPassword
    case incorrectUsername
    case unknownError(message: String)
}
