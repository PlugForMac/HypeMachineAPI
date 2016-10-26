//
//  BlogsRouter.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    public enum Blogs: URLRequestConvertible {
        
        case index(params: Parameters?)
        case show(id: Int)
        case showTracks(id: Int, params: Parameters?)
        
        var method: HTTPMethod {
            switch self {
            case .index:
                return .get
            case .show:
                return .get
            case .showTracks:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .index:
                return "/blogs"
            case .show(let id):
                return "/blogs/\(id)"
            case .showTracks(let id, _):
                return "/blogs/\(id)/tracks"
            }
        }
        
        var params: Parameters? {
            switch self {
            case .index(let optionalParams):
                return optionalParams
            case .show:
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
