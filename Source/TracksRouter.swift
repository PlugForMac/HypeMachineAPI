//
//  TracksRouter.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/10/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    public enum Tracks: URLRequestConvertible {
        
        case Index([String: AnyObject]?)
        case Show(String)
        case Popular([String: AnyObject]?)
        
        var method: Alamofire.Method {
            switch self {
            case .Index:
                return .GET
            case .Show:
                return .GET
            case .Popular:
                return .GET
            }
        }
        
        var path: String {
            switch self {
            case .Index:
                return "/tracks"
            case .Show(let id):
                return "/tracks/\(id)"
            case .Popular:
                return "/popular"
            }
        }
        
        // MARK: URLRequestConvertible
        
        public var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            switch self {
            case .Index(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case .Show:
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
            case .Popular(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            }
        }
    }
}