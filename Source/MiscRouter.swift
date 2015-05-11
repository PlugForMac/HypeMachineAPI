//
//  MiscRouter.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    public enum Misc: URLRequestConvertible {
        
        case GetToken([String: AnyObject])
        
        var method: Alamofire.Method {
            switch self {
            case .GetToken:
                return .POST
            }
        }
        
        var path: String {
            switch self {
            case .GetToken:
                return "/get_token"
            }
        }
        
        public var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            switch self {
            case .GetToken(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            }
        }
    }
}