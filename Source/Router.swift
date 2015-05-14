//
//  Router.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/10/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

public struct Router {
    static let baseURLString = "https://api.hypem.com/v2"
    
    static func URLRequest(#method: Alamofire.Method, path: String, params: [String: AnyObject]?) -> NSURLRequest {
        let URL = NSURL(string: baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: params).0
    }
}