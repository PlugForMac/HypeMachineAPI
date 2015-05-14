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
        public static func index(optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Tracks.Index(optionalParams)).validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
        
        public static func show(#id: String, callback: (track: Track?, error: NSError?)->Void) {
            Alamofire.request(Router.Tracks.Show(id)).validate().responseObject {
                (request, response, track: Track?, error) in
                callback(track: track, error: error)
            }
        }
        
        public static func popular(optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Tracks.Popular(optionalParams)).validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
    }
}