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
        
        case index
        case showTracks(name: String, params: Parameters?)
        
        var method: HTTPMethod {
            switch self {
            case .index:
                return .get
            case .showTracks:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .index:
                return "/tags"
            case .showTracks(let name, _):
                let escapedName = name.stringByAddingPercentEncodingForURLQueryValue()!
                return "/tags/\(escapedName)/tracks"
            }
        }
        
        var params: Parameters? {
            switch self {
            case .index:
                return nil
            case .showTracks(_, let optionalParams):
                return optionalParams
            }
        }
        
        public func asURLRequest() throws -> URLRequest {
            return try Router.GenerateURLRequest(method: method, path: path, params: params)
        }
    }
}
