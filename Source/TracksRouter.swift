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
        
        case Index
        case Show(String)
        
        var method: Alamofire.Method {
            switch self {
            case .Index:
                return .GET
            case .Show:
                return .GET
            }
        }
        
        var path: String {
            switch self {
            case .Index:
                return "/tracks"
            case .Show(let id):
                return "/tracks/\(id)"
            }
        }
        
        // MARK: URLRequestConvertible
        
        public var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            switch self {
            case .Index:
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
            case .Show:
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
            }
        }
    }
}