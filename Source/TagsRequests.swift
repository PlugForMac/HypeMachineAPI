//
//  TagsRequests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/13/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Requests {
    public struct Tags {
        public static func index(
            _ completionHandler: @escaping (DataResponse<[Tag]>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Tags.index)
                .responseCollection(completionHandler: completionHandler)
        }
        
        public static func showTracks(
            name: String,
            params: Parameters? = nil,
            completionHandler: @escaping (DataResponse<[Track]>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Tags.showTracks(name: name, params: params))
                .responseCollection(completionHandler: completionHandler)
        }
    }
}
