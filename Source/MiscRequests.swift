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
        public static func getToken(
            usernameOrEmail: String,
            password: String,
            completionHandler: @escaping (DataResponse<UsernameAndToken>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Misc.getToken(usernameOrEmail: usernameOrEmail, password: password))
                .responseUsernameAndToken(completionHandler: completionHandler)
        }
    }
}

public struct UsernameAndToken {
    public let username: String
    public let token: String
    
    init(username: String, token: String) {
        self.username = username
        self.token = token
    }
}
