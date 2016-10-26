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
    
    static func GenerateURLRequest(method: HTTPMethod, path: String, params: Parameters?) throws -> URLRequest {
        
        // Probably a bug in the hype machine API, but hm_token must be part of the path, can't be form encoded
        var urlString = baseURLString + path
        if hmToken != nil {
            urlString += "?hm_token=\(hmToken!)"
        }
        let URL = try urlString.asURL()
        var urlRequest = URLRequest(url: URL)
        urlRequest.httpMethod = method.rawValue
        
        if userAgent != nil {
            urlRequest.addValue(userAgent!, forHTTPHeaderField: "User-Agent")
        }
        
        let mergedParams = addApiKeyParam(params ?? [:])
        
        return try URLEncoding.default.encode(urlRequest, with: mergedParams)
    }
    
    static func addApiKeyParam(_ params: Parameters) -> Parameters {
        if apiKey == nil { return params }
        return ["key": apiKey!].merge(params)
    }
}
