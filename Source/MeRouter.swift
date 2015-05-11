//
//  MeRouter.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    public enum Me: URLRequestConvertible {
        
        case Favorites([String: AnyObject]?)
        case AddFavorite([String: AnyObject]?)
        case Friends([String: AnyObject]?)
        case Feed([String: AnyObject]?)
        
        var method: Alamofire.Method {
            switch self {
            case .Favorites:
                return .GET
            case .AddFavorite:
                return .POST
            case .Friends:
                return .GET
            case .Feed:
                return .GET
            }
        }
        
        var path: String {
            switch self {
            case .Favorites:
                return "/me/favorites"
            case .AddFavorite:
                return "/me/favorites"
            case .Friends:
                return "/me/friends"
            case .Feed:
                return "/me/feed"
            }
        }
        
        public var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            switch self {
            case .Favorites(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case .AddFavorite(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case .Friends(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case .Feed(let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            }
        }
    }
}