//
//  Friend.swift
//  Plug
//
//  Created by Alex Marchant on 8/1/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public final class User: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    public let username: String
    public let fullName: String?
    public let avatarURL: NSURL?
    public let favoritesCount: Int
    public let favoritesCountNum: NSNumber
    public let followersCount: Int
    public let followersCountNum: NSNumber
    public let followingCount: Int
    public let followingCountNum: NSNumber
    public var friend: Bool?
    public var follower: Bool?
    
    override public var description: String {
        return "<User - username: \(username), fullName: \(fullName)>"
    }
    
    public required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        guard
            let username = representation["username"] as? String,
            let favoritesCountInfo = representation["favorites_count"] as? NSDictionary
        else {
            // Shouldn't need this, probably a bug, delete later
            self.username = ""
            self.fullName = nil
            self.avatarURL = nil
            self.favoritesCount = 0
            self.favoritesCountNum = NSNumber()
            self.followersCount = 0
            self.followersCountNum = NSNumber()
            self.followingCount = 0
            self.followingCountNum = NSNumber()
            self.friend = false
            self.follower = false
            super.init()
            // Shouldn't need this, probably a bug, delete later
            return nil
        }
        
        self.username = username
        
        if let fullName = representation["fullname"] as? String {
            self.fullName = fullName == "" ? nil : fullName
        } else {
            self.fullName = nil
        }
        
        if let avatarURLString = representation["userpic"] as? String,
            let avatarURL = NSURL(string: avatarURLString) {
            self.avatarURL = avatarURL
        } else {
            self.avatarURL = nil
        }
        
        self.favoritesCount = favoritesCountInfo["item"] as? Int ?? 0
        self.favoritesCountNum = NSNumber(integer: favoritesCount)
        
        self.followersCount = favoritesCountInfo["followers"] as? Int ?? 0
        self.followersCountNum = NSNumber(integer: followersCount)

        self.followingCount = favoritesCountInfo["user"] as? Int ?? 0
        self.followingCountNum = NSNumber(integer: followingCount)

        self.friend = representation["is_friend"] as? Bool
        self.follower = representation["is_follower"] as? Bool
        
        super.init()
    }
    
    public class func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [User] {
        var users = [User]()
        
        if let collectionJSON = representation as? [NSDictionary] {
            for recordJSON in collectionJSON {
                if let user = User(response: response, representation: recordJSON) {
                    users.append(user)
                }
            }
        }
        
        return users
    }
}
