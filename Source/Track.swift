//
//  Track.swift
//  Plug
//
//  Created by Alexander Marchant on 7/16/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public struct Track: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    public let id: String
    public let artist: String
    public let title: String
    public let lovedCount: Int
    public let lovedCountNum: NSNumber
    public let thumbURLSmall: URL?
    public let thumbURLMedium: URL?
    public let thumbURLLarge: URL?
    public let rank: Int?
    public let viaUser: String?
    public let viaQuery: String?
    public let postedBy: String
    public let postedById: Int
    public let postedCount: Int
    public let postedByDescription: String
    public let datePosted: Date
    public let audioUnavailable: Bool
    public let postURL: URL
    public let iTunesURL: URL
    public let mediaType: String?

    public var loved: Bool
    
    public var description: String {
        return "Track: { artist: \(artist), title: \(title) }"
    }
    
    public init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let id = representation["itemid"] as? String,
            let artist = representation["artist"] as? String,
            let title = representation["title"] as? String,
            let lovedCount = representation["loved_count"] as? Int,
            let postedBy = representation["sitename"] as? String,
            let postedById = representation["siteid"] as? Int,
            let postedCount = representation["posted_count"] as? Int,
            let datePostedInterval = representation["dateposted"] as? TimeInterval,
            let postURLString = representation["posturl"] as? String,
            let postURLStringEscaped = postURLString.stringByAddingPercentEncodingForURLQueryValue(),
            let postURL = URL(string: postURLStringEscaped),
            let iTunesURLString = representation["itunes_link"] as? String,
            let iTunesURLStringEscaped = iTunesURLString.stringByAddingPercentEncodingForURLQueryValue(),
            let iTunesURL = URL(string: iTunesURLStringEscaped)
        else { return nil }
        
        func urlForJSONKey(_ key: String) -> URL? {
            guard let urlString = representation[key] as? String else {
                return nil
            }
            return URL(string: urlString)
        }
        
        self.id = id
        self.artist = artist == "" ? "Unknown artist" : artist
        self.title = title == "" ? "Unknown track" : title
        self.loved = representation["ts_loved_me"] is Int
        self.lovedCount = lovedCount
        self.lovedCountNum = NSNumber(value: lovedCount as Int)
        self.thumbURLSmall = urlForJSONKey("thumb_url")
        self.thumbURLMedium = urlForJSONKey("thumb_url_medium")
        self.thumbURLLarge = urlForJSONKey("thumb_url_large")
        self.rank = representation["rank"] as? Int
        self.viaUser = representation["via_user"] as? String
        self.viaQuery = representation["via_query"] as? String
        self.postedBy = postedBy
        self.postedById = postedById
        self.postedCount = postedCount
        self.postedByDescription = (representation["description"] as? String) ?? "No description available"
        self.datePosted = Date(timeIntervalSince1970: datePostedInterval)
        self.audioUnavailable = representation["pub_audio_unavail"] as? Bool == true
        self.postURL = postURL
        self.iTunesURL = iTunesURL
        self.mediaType = representation["media_type"] as? String
    }
    
    public func mediaURL() -> URL {
        var mediaLinkString = "https://hypem.com/serve/public/\(id)"
        if apiKey != nil {
            mediaLinkString += "?key=\(apiKey!)"
        }
        return URL(string: mediaLinkString)!
    }
    
    public func thumbURL(preferedSize: ImageSize) -> URL {
        switch preferedSize {
        case .large:
            if thumbURLLarge != nil {
                return thumbURLLarge!
            } else if thumbURLMedium != nil {
                return thumbURLMedium!
            } else {
                return thumbURLSmall!
            }
        case .medium:
            if thumbURLMedium != nil {
                return thumbURLMedium!
            } else if thumbURLLarge != nil {
                return thumbURLLarge!
            } else {
                return thumbURLSmall!
            }
        case .small:
            if thumbURLSmall != nil {
                return thumbURLSmall!
            } else if thumbURLMedium != nil {
                return thumbURLMedium!
            } else {
                return thumbURLLarge!
            }
        }
    }
    
    public func hypeMachineURL() -> URL {
        return URL(string: "http://hypem.com/track/\(id)")!
    }
    
    public enum ImageSize {
        case small
        case medium
        case large
    }
}
