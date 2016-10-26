//
//  TracksRequests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/13/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Requests {
    public struct Tracks {
        public static func index(
            params: Parameters? = nil,
            completionHandler: @escaping (DataResponse<[Track]>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Tracks.index(params: params))
                .responseCollection(completionHandler: completionHandler)
        }
        
        public static func show(
            id: String,
            completionHandler: @escaping (DataResponse<Track>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Tracks.show(id: id))
                .responseObject(completionHandler: completionHandler)
        }
        
        public static func popular(
            params: Parameters? = nil,
            completionHandler: @escaping (DataResponse<[Track]>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Tracks.popular(params: params))
                .responseCollection(completionHandler: completionHandler)
        }
    }
}
