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
        public static func index(optionalParams optionalParams: [String: AnyObject]?, callback: (artists: [Artist]?, error: NSError?)->Void) {
            Alamofire.request(Router.Artists.Index(optionalParams)).validateAPI().validate().responseCollection {
                (request, response, artists: [Artist]?, error) in
                callback(artists: artists, error: error)
            }
        }
        
        public static func show(name name: String, callback: (artist: Artist?, error: NSError?)->Void) {
            Alamofire.request(Router.Artists.Show(name)).validateAPI().validate().responseObject {
                (request, response, artist: Artist?, error) in
                callback(artist: artist, error: error)
            }
        }
        
        public static func showTracks(name name: String, optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Artists.ShowTracks(name, optionalParams)).validateAPI().validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
    }
}