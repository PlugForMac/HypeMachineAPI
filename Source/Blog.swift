//
//  Blog.swift
//  Plug
//
//  Created by Alex Marchant on 7/25/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public class Blog: NSObject {
    let id: String
    let name: String
    let url: NSURL
    let followerCount: Int
    let followerCountNum: NSNumber
    let trackCount: Int
    let trackCountNum: NSNumber
    let imageURL: NSURL
    let imageURLSmall: NSURL
    let featured: Bool
    let following: Bool
    
    public required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("siteid") as! String
        self.name = representation.valueForKeyPath("sitename") as! String
        var urlString = (representation.valueForKeyPath("siteurl") as! String)
            .stringByReplacingOccurrencesOfString(" ", withString: "")
        self.url = NSURL(string: urlString)!
        self.followerCount = representation.valueForKeyPath("followers") as! Int
        self.followerCountNum = NSNumber(integer: self.followerCount)
        self.trackCount = representation.valueForKeyPath("total_tracks") as! Int
        self.trackCountNum = NSNumber(integer: trackCount)
        self.imageURL = NSURL(string: representation.valueForKeyPath("blog_image") as! String)!
        self.imageURLSmall = NSURL(string: representation.valueForKeyPath("blog_image_small") as! String)!
        self.featured = representation.valueForKeyPath("ts_featured") is String
        self.following = representation.valueForKeyPath("ts_featured") is String
    }
    
    public func imageURLForSize(size: ImageSize) -> NSURL {
        switch size {
        case .Normal:
            return imageURL
        case .Small:
            return imageURLSmall
        }
    }
    
    public enum ImageSize {
        case Normal
        case Small
    }
}
