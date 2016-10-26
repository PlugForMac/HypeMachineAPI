//
//  BlogsRequests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/13/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Requests {
    public struct Blogs {
        public static func index(
            params: Parameters? = nil,
            completionHandler: @escaping (DataResponse<[Blog]>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Blogs.index(params: params))
                .responseCollection(completionHandler: completionHandler)
        }
        
        public static func show(
            id: Int,
            completionHandler: @escaping (DataResponse<Blog>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Blogs.show(id: id))
                .responseObject(completionHandler: completionHandler)
        }
        
        public static func showTracks(
            id: Int,
            params: Parameters? = nil,
            completionHandler: @escaping (DataResponse<[Track]>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Blogs.showTracks(id: id, params: params))
                .responseCollection(completionHandler: completionHandler)
        }
    }
}
