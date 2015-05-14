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
        public static func Favorites(optionalParams: [String: AnyObject]?, response: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.Favorites(optionalParams)).responseCollection {
                (_, _, tracks: [Track]?, error) in
                response(tracks: tracks, error: error)
            }
        }
        
        public static func AddFavorite(#id: String, optionalParams: [String: AnyObject]?, response: (favorited: Bool?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.AddFavorite(id, optionalParams)).responseString {
                (_, _, string, error) in
                var favorited: Bool? = string == "1"
                response(favorited: favorited, error: error)
            }
        }
        
        public static func Friends(optionalParams: [String: AnyObject]?, response: (users: [User]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.Friends(optionalParams)).responseCollection {
                (_, _, users: [User]?, error) in
                response(users: users, error: error)
            }
        }
        
        public static func Feed(optionalParams: [String: AnyObject]?, response: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Me.Feed(optionalParams)).responseCollection {
                (_, _, tracks: [Track]?, error) in
                response(tracks: tracks, error: error)
            }
        }
    }
}