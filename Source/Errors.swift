//
//  Errors.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 7/14/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation

let ErrorDomain = "HypeMachineAPI.ErrorDomain"

public struct Errors {
    public static func parseAPIErrorFromJSON(JSON: AnyObject?) -> NSError? {
        guard
            let JSON = JSON,
            let JSONDictionary = JSON as? NSDictionary,
            let errorMessage = JSONDictionary["error_msg"] as? String
            else {
                return nil
        }
        
        let userInfo: [NSObject: AnyObject] = [NSLocalizedDescriptionKey: errorMessage]
        
        switch errorMessage {
        case "Must provide valid hm_token":
            return NSError(domain: ErrorDomain, code: ErrorCodes.InvalidHMToken.rawValue, userInfo: userInfo)
        case "Wrong password":
            return NSError(domain: ErrorDomain, code: ErrorCodes.WrongPassword.rawValue, userInfo: userInfo)
        default:
            return NSError(domain: ErrorDomain, code: ErrorCodes.UnknownError.rawValue, userInfo: userInfo)
        }
    }
}

public enum ErrorCodes: Int {
    case UnknownError
    case WrongPassword
    case InvalidHMToken
}