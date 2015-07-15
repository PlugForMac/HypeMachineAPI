//
//  MiscRequests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/13/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Requests {
    public struct Misc {
        public static func getToken(#usernameOrEmail: String, password: String, callback: (username: String?, token: String?, error: NSError?)->Void) {
            Alamofire.request(Router.Misc.GetToken(usernameOrEmail, password)).validate().responseJSON {
                (req, resp, JSON, error) in
                let username: String? = JSON?.valueForKeyPath("username") as? String
                let token: String? = JSON?.valueForKeyPath("hm_token") as? String
                
                // TODO: This is rough and should be implemented across all requests
                if let errorMessage = JSON?.valueForKeyPath("error_msg") as? String {
                    if errorMessage == "Wrong password" {
                        let hypeError = NSError(domain: ErrorDomain, code: Errors.ErrorCodes.WrongPassword.rawValue, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        callback(username: username, token: token, error: hypeError)
                        return
                    }
                }
                
                callback(username: username, token: token, error: error)
            }
        }
    }
}