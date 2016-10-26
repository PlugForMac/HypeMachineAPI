//
//  ArtistsRequests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/13/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Requests {
    public struct Artists {
        public static func index(
            params: Parameters? = nil,
            completionHandler: @escaping (DataResponse<[Artist]>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Artists.index(params: params))
                .responseCollection(completionHandler: completionHandler)
        }
        
        public static func show(
            name: String,
            completionHandler: @escaping (DataResponse<Artist>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Artists.show(id: name))
                .responseObject(completionHandler: completionHandler)
        }
        
        public static func showTracks(
            name: String,
            params: Parameters? = nil,
            completionHandler: @escaping (DataResponse<[Track]>)->Void
            ) -> DataRequest
        {
            return Requests
                .defaultRequest(Router.Artists.showTracks(name: name, params: params))
                .responseCollection(completionHandler: completionHandler)
        }
    }
}
