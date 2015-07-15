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
                let escapedName = name.stringByAddingPercentEncodingForURLQueryValue()!
                return "/artists/\(escapedName)"
            case .ShowTracks(let name, _):
                let escapedName = name.stringByAddingPercentEncodingForURLQueryValue()!
                return "/artists/\(escapedName)/tracks"
            }
        }
        
        var params: [String: AnyObject]? {
            switch self {
            case .Index(let optionalParams):
                return optionalParams
            case .Show:
                return nil
            case .ShowTracks(_, let optionalParams):
                return optionalParams
            }
        }
        
        public var URLRequest: NSURLRequest {
            return Router.URLRequest(method: method, path: path, params: params)
        }
    }
}