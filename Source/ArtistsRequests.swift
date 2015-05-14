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
        public static func Index(optionalParams: [String: AnyObject]?, callback: (artists: [Artist]?, error: NSError?)->Void) {
            Alamofire.request(Router.Artists.Index(optionalParams)).validate().responseCollection {
                (request, response, artists: [Artist]?, error) in
                callback(artists: artists, error: error)
            }
        }
        
        public static func Show(#id: String, callback: (artist: Artist?, error: NSError?)->Void) {
            Alamofire.request(Router.Artists.Show(id)).validate().responseObject {
                (request, response, artist: Artist?, error) in
                callback(artist: artist, error: error)
            }
        }
        
        public static func ShowTracks(#id: String, optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Artists.ShowTracks(id, optionalParams)).validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
    }
}