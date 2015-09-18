//
//  Blog.swift
//  Plug
//
//  Created by Alex Marchant on 7/25/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public final class Blog: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    public let id: Int
    public let name: String
    public let url: NSURL
    public let followerCount: Int
    public let followerCountNum: NSNumber
    public let trackCount: Int
    public let trackCountNum: NSNumber
    public let imageURL: NSURL
    public let imageURLSmall: NSURL
    public let featured: Bool
    public let following: Bool
    
    override public var description: String {
        return "<Blog - name: \(name)>"
    }
    
    public required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("siteid") as! Int
        self.name = representation.valueForKeyPath("sitename") as! String
        let urlString = (representation.valueForKeyPath("siteurl") as! String)
            .stringByReplacingOccurrencesOfString(" ", withString: "")
        self.url = NSURL(string: urlString)!
        self.followerCount = representation.valueForKeyPath("followers") as! Int
        self.followerCountNum = NSNumber(integer: self.followerCount)
        self.trackCount = representation.valueForKeyPath("total_tracks") as! Int
        self.trackCountNum = NSNumber(integer: trackCount)
        self.imageURL = NSURL(string: representation.valueForKeyPath("blog_image") as! String)!
        self.imageURLSmall = NSURL(string: representation.valueForKeyPath("blog_image_small") as! String)!
        self.featured = representation.valueForKeyPath("ts_featured") != nil
        self.following = representation.valueForKeyPath("ts_loved_me") != nil
    }
    
    public class func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Blog] {
        var blogs = [Blog]()
        
        if let collectionJSON = representation as? [NSDictionary] {
            for recordJSON in collectionJSON {
                if let blog = Blog(response: response, representation: recordJSON) {
                    blogs.append(blog)
                }
            }
        }
        
        return blogs
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
