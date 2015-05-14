//
//  UsersRequests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/13/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Requests {
    public struct Users {
        public static func Show(#id: String, response: (user: User?, error: NSError?)->Void) {
            Alamofire.request(Router.Users.Show(id)).validate().responseObject {
                (_, _, user: User?, error) in
                response(user: user, error: error)
            }
        }
        
        public static func ShowFavorites(#id: String, optionalParams: [String: AnyObject]?, response: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Users.ShowFavorites(id, optionalParams)).validate().responseCollection {
                (_, _, tracks: [Track]?, error) in
                response(tracks: tracks, error: error)
            }
        }
        
        public static func ShowFriends(#id: String, optionalParams: [String: AnyObject]?, response: (users: [User]?, error: NSError?)->Void) {
            Alamofire.request(Router.Users.ShowFriends(id, optionalParams)).validate().responseCollection {
                (_, _, users: [User]?, error) in
                response(users: users, error: error)
            }
        }
    }
}