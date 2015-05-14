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
        public static func Favorites(optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.Favorites(optionalParams)).validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
        
        public static func AddFavorite(#id: String, optionalParams: [String: AnyObject]?, callback: (favorited: Bool?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.AddFavorite(id, optionalParams)).validate().responseString {
                (request, response, string, error) in
                var favorited: Bool? = string == "1"
                callback(favorited: favorited, error: error)
            }
        }
        
        public static func Friends(optionalParams: [String: AnyObject]?, callback: (users: [User]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.Friends(optionalParams)).validate().responseCollection {
                (request, response, users: [User]?, error) in
                callback(users: users, error: error)
            }
        }
        
        public static func Feed(optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.Feed(optionalParams)).validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
    }
}