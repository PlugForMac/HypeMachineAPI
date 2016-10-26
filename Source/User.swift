//
//  Friend.swift
//  Plug
//
//  Created by Alex Marchant on 8/1/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public struct User: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    public let username: String
    public let fullName: String?
    public let avatarURL: URL?
    public let favoritesCount: Int
    public let favoritesCountNum: NSNumber
    public let followersCount: Int
    public let followersCountNum: NSNumber
    public let followingCount: Int
    public let followingCountNum: NSNumber
    public var friend: Bool?
    public var follower: Bool?
    
    public var description: String {
        return "User: { username: \(username), fullName: \(fullName) }"
    }
    
    public init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let username = representation["username"] as? String,
            let favoritesCountInfo = representation["favorites_count"] as? NSDictionary
        else { return nil }
        
        func nonEmptyStringForJSONKey(_ key: String) -> String? {
            guard let string = representation["key"] as? String else {
                return nil
            }
            return string == "" ? nil : string
        }
        
        func urlForJSONKey(_ key: String) -> URL? {
            guard let urlString = representation[key] as? String else {
                return nil
            }
            return URL(string: urlString)
        }
        
        self.username = username
        self.fullName = nonEmptyStringForJSONKey("fullname")
        self.avatarURL = urlForJSONKey("userpic")
        self.favoritesCount = favoritesCountInfo["item"] as? Int ?? 0
        self.favoritesCountNum = NSNumber(value: favoritesCount as Int)
        self.followersCount = favoritesCountInfo["followers"] as? Int ?? 0
        self.followersCountNum = NSNumber(value: followersCount as Int)
        self.followingCount = favoritesCountInfo["user"] as? Int ?? 0
        self.followingCountNum = NSNumber(value: followingCount as Int)
        self.friend = representation["is_friend"] as? Bool
        self.follower = representation["is_follower"] as? Bool
    }
}
