//
//  ArtistsRouter.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    public enum Artists: URLRequestConvertible {
        
        case Index([String: AnyObject]?)
        case Show(String)
        case ShowTracks(String, [String: AnyObject]?)
        
        var method: Alamofire.Method {
            switch self {
            case .Index:
                return .GET
            case .Show:
                return .GET
            case .ShowTracks:
                return .GET
            }
        }
        
        var path: String {
            switch self {
            case .Index:
                return "/artists"
            case .Show(let name):
                return "/artists/\(name)"
            case .ShowTracks(let name, _):
                return "/artists/\(name)/tracks"
            }
        }
        
        public var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            switch self {
            case .Index(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case .Show:
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
            case .ShowTracks(_, let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            }
        }
    }
}