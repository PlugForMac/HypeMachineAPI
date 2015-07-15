//
//  MeRequests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/13/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Requests {
    public struct Me {
        public static func favorites(#optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.Favorites(optionalParams)).validateAPI().validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
        
        public static func toggleTrackFavorite(#id: String, optionalParams: [String: AnyObject]?, callback: (favorited: Bool?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.ToggleTrackFavorite(id, optionalParams)).validateAPI().validate().responseString {
                (request, response, string, error) in
                var favorited: Bool?
                if string != nil {
                    favorited = (string! == "1")
                }
                callback(favorited: favorited, error: error)
            }
        }
        
        public static func toggleBlogFavorite(#id: Int, optionalParams: [String: AnyObject]?, callback: (favorited: Bool?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.ToggleBlogFavorite(id, optionalParams)).validateAPI().validate().responseString {
                (request, response, string, error) in
                var favorited: Bool?
                if string != nil {
                    favorited = (string! == "1")
                }
                callback(favorited: favorited, error: error)
            }
        }
        
        public static func toggleUserFavorite(#id: String, optionalParams: [String: AnyObject]?, callback: (favorited: Bool?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.ToggleUserFavorite(id, optionalParams)).validateAPI().validate().responseString {
                (request, response, string, error) in
                var favorited: Bool?
                if string != nil {
                    favorited = (string! == "1")
                }
                callback(favorited: favorited, error: error)
            }
        }
        
        public static func playlistNames(callback: (names: [String]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.PlaylistNames).validateAPI().validate().responseJSON {
                (request, response, JSON, error) in
                let names = JSON as? [String]
                callback(names: names, error: error)
            }
        }
        
        // Playlist id's are 1...3
        public static func showPlaylist(#id: Int, optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.ShowPlaylist(id, optionalParams)).validateAPI().validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
        
        public static func friends(#optionalParams: [String: AnyObject]?, callback: (users: [User]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.Friends(optionalParams)).validateAPI().validate().responseCollection {
                (request, response, users: [User]?, error) in
                callback(users: users, error: error)
            }
        }
        
        public static func feed(#optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.Feed(optionalParams)).validateAPI().validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
        
//        static func parseInvalidTokenError(
    }
}