//
//  TagsRouter.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    public enum Tags: URLRequestConvertible {
        
        case Index
        case ShowTracks(String, [String: AnyObject]?)
        
        var method: Alamofire.Method {
            switch self {
            case .Index:
                return .GET
            case .ShowTracks:
                return .GET
            }
        }
        
        var path: String {
            switch self {
            case .Index:
                return "/tags"
            case .ShowTracks(let name, _):
                return "/tags/\(name)/tracks"
            }
        }
        
        public var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            switch self {
            case .Index:
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
            case .ShowTracks(_, let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            }
        }
    }
}