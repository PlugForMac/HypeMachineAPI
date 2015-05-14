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
        public static func Index(optionalParams: [String: AnyObject]?, response: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Tracks.Index(optionalParams)).validate().responseCollection {
                (_, _, tracks: [Track]?, error) in
                response(tracks: tracks, error: error)
            }
        }
        
        public static func Show(#id: String, response: (track: Track?, error: NSError?)->Void) {
            Alamofire.request(Router.Tracks.Show(id)).validate().responseObject {
                (_, _, track: Track?, error) in
                response(track: track, error: error)
            }
        }
        
        public static func Popular(optionalParams: [String: AnyObject]?, response: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Tracks.Popular(optionalParams)).validate().responseCollection {
                (_, _, tracks: [Track]?, error) in
                response(tracks: tracks, error: error)
            }
        }
    }
}