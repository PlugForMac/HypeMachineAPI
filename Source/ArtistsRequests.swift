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
        public static func Index(optionalParams: [String: AnyObject]?, response: (artists: [Artist]?, error: NSError?)->Void) {
            Alamofire.request(Router.Artists.Index(optionalParams)).validate().responseCollection {
                (_, _, artists: [Artist]?, error) in
                response(artists: artists, error: error)
            }
        }
        
        public static func Show(#id: String, response: (artist: Artist?, error: NSError?)->Void) {
            Alamofire.request(Router.Artists.Show(id)).validate().responseObject {
                (_, _, artist: Artist?, error) in
                response(artist: artist, error: error)
            }
        }
        
        public static func ShowTracks(#id: String, optionalParams: [String: AnyObject]?, response: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Artists.ShowTracks(id, optionalParams)).validate().responseCollection {
                (_, _, tracks: [Track]?, error) in
                response(tracks: tracks, error: error)
            }
        }
    }
}