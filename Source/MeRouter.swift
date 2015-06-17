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
        case AddFavorite(String, [String: AnyObject]?)
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
        
        var params: [String: AnyObject]? {
            switch self {
            case .Favorites(let optionalParams):
                return optionalParams
            case .AddFavorite(let id, let optionalParams):
                return ["val": id, "type": "item"].merge(optionalParams)
            case .Friends(let optionalParams):
                return optionalParams
            case .Feed(let optionalParams):
                return optionalParams
            }
        }
        
        public var URLRequest: NSURLRequest {
            return Router.URLRequest(method: method, path: path, params: params)
        }
    }
}