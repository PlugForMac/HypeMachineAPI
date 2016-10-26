//
//  Blog.swift
//  Plug
//
//  Created by Alex Marchant on 7/25/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public struct Blog: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    public let id: Int
    public let name: String
    public let url: URL
    public let followerCount: Int
    public let followerCountNum: NSNumber
    public let trackCount: Int
    public let trackCountNum: NSNumber
    public let imageURL: URL
    public let imageURLSmall: URL
    public let featured: Bool
    public let following: Bool
    
    public var description: String {
        return "Blog: { name: \(name) }"
    }
    
    public init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let id = representation["siteid"] as? Int,
            let name = representation["sitename"] as? String,
            let urlString = representation["siteurl"] as? String,
            let url = URL(string: urlString.replacingOccurrences(of: " ", with: "")),
            let followerCount = representation["followers"] as? Int,
            let trackCount = representation["total_tracks"] as? Int,
            let imageURLString = representation["blog_image"] as? String,
            let imageURL = URL(string: imageURLString),
            let imageURLSmallString = representation["blog_image_small"] as? String,
            let imageURLSmall = URL(string: imageURLSmallString)
        else { return nil }
        
        self.id = id
        self.name = name
        self.url = url
        self.followerCount = followerCount
        self.followerCountNum = NSNumber(value: followerCount as Int)
        self.trackCount = trackCount
        self.trackCountNum = NSNumber(value: trackCount as Int)
        self.imageURL = imageURL
        self.imageURLSmall = imageURLSmall
        self.featured = representation["ts_featured"] is Int
        self.following = representation["ts_loved_me"] is Int
    }
    
    public func imageURL(size: ImageSize) -> URL {
        switch size {
        case .normal:
            return imageURL
        case .small:
            return imageURLSmall
        }
    }
    
    public enum ImageSize {
        case normal
        case small
    }
}
