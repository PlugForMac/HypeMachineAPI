//
//  Friend.swift
//  Plug
//
//  Created by Alex Marchant on 8/1/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public class Friend: NSObject {
    let username: String
    let fullName: String
    let avatarURL: NSURL?
    let favoritesCount: Int
    let favoritesCountNum: NSNumber
    let followersCount: Int
    let followersCountNum: NSNumber
    let followingCount: Int
    let followingCountNum: NSNumber
    
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
        followingCountNum = NSNumber(integer: followingCount)
    }
}
