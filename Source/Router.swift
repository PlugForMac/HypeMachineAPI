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
        
        var mergedParams: [String: AnyObject]?
        mergedParams = addApiKeyParam(params)
        mergedParams = addHMTokenParam(mergedParams)
        
        return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: mergedParams).0
    }
    
    static func addApiKeyParam(params: [String: AnyObject]?) -> [String: AnyObject]? {
        if apiKey == nil { return params }
        return ["key": apiKey!].merge(params)
    }
    
    static func addHMTokenParam(params: [String: AnyObject]?) -> [String: AnyObject]? {
        if hmToken == nil { return params }
        return ["hm_token": hmToken!].merge(params)
    }
}