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
        public static func Index(callback: (tags: [Tag]?, error: NSError?)->Void) {
            Alamofire.request(Router.Tags.Index).validate().responseCollection {
                (request, response, tags: [Tag]?, error) in
                callback(tags: tags, error: error)
            }
        }
        
        public static func ShowTracks(#name: String, optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Tags.ShowTracks(name, optionalParams)).validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
    }
}