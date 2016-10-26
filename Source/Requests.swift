//
//  Requests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/13/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

public struct Requests {
    public static func defaultRequest(_ urlRequest: URLRequestConvertible) -> Alamofire.DataRequest {
        return Alamofire
            .request(urlRequest)
            .validate()
            .validate(Validations.apiErrorValidation)
    }
}
