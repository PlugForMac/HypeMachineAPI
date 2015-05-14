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
    public let fullName: String
    public let avatarURL: NSURL?
    public let favoritesCount: Int
    public let favoritesCountNum: NSNumber
    public let followersCount: Int
    public let followersCountNum: NSNumber
    public let followingCount: Int
    public let followingCountNum: NSNumber
    
    override public var description: String {
        return "<User - username: \(username), fullName: \(fullName)>"
    }
    
    public required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.username = representation.valueForKeyPath("username") as! String
        if let fullname = representation.valueForKeyPath("fullname") as? String {
            self.fullName = fullname
        } else {
            self.fullName = username
        }
        if let userpic = representation.valueForKeyPath("userpic") as? String {
            self.avatarURL = NSURL(string: userpic)
        } else {
            self.avatarURL = nil
        }
        let favoritesCountInfo = (representation.valueForKeyPath("favorites_count") as! NSDictionary)
        
        self.favoritesCount = favoritesCountInfo.valueForKeyPath("item") as? Int ?? 0
        self.favoritesCountNum = NSNumber(integer: favoritesCount)
        
        self.followersCount = favoritesCountInfo.valueForKeyPath("followers") as? Int ?? 0
        self.followersCountNum = NSNumber(integer: followersCount)

        self.followingCount = favoritesCountInfo.valueForKeyPath("user") as? Int ?? 0
        self.followingCountNum = NSNumber(integer: followingCount)
    }
    
    public class func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [User]? {
        var users = [User]()
        
        if let collectionJSON = representation as? [NSDictionary] {
            for recordJSON in collectionJSON {
                if let user = User(response: response, representation: recordJSON) {
                    users.append(user)
                }
            }
        } else {
            return nil
        }
        
        return users
    }
}