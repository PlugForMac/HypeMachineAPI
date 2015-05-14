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
        public static func Index(response: (tags: [Tag]?, error: NSError?)->Void) {
            Alamofire.request(Router.Tags.Index).responseCollection {
                (_, _, tags: [Tag]?, error) in
                response(tags: tags, error: error)
            }
        }
        
        public static func ShowTracks(#name: String, optionalParams: [String: AnyObject]?, response: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Tags.ShowTracks(name, optionalParams)).responseCollection {
                (_, _, tracks: [Track]?, error) in
                response(tracks: tracks, error: error)
            }
        }
    }
}