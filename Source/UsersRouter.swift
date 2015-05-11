//
//  UsersRouter.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    public enum Users: URLRequestConvertible {
        
        case Show(String)
        case ShowFavorites(String, [String: AnyObject]?)
        case ShowFriends(String)
        
        var method: Alamofire.Method {
            switch self {
            case .Show:
                return .GET
            case .ShowFavorites:
                return .GET
            case .ShowFriends:
                return .GET
            }
        }
        
        var path: String {
            switch self {
            case .Show(let username):
                return "/users/\(username)"
            case .ShowFavorites(let username, _):
                return "/users/\(username)/favorites"
            case .ShowFriends(let username):
                return "/users/\(username)/friends"
            }
        }
        
        public var URLRequest: NSURLRequest {
            let URL = NSURL(string: Router.baseURLString)!
            let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            mutableURLRequest.HTTPMethod = method.rawValue
            
            switch self {
            case .Show:
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
            case .ShowFavorites(_, let params):
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
            case .ShowFriends:
                return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
            }
        }
    }
}