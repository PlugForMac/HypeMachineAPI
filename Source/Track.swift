//
//  Track.swift
//  Plug
//
//  Created by Alexander Marchant on 7/16/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public final class Track: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    public let id: String
    public let artist: String
    public let title: String
    public let loved: Bool
    public let lovedCount: Int
    public let lovedCountNum: NSNumber
    public let thumbURLSmall: NSURL?
    public let thumbURLMedium: NSURL?
    public let thumbURLLarge: NSURL?
    public let rank: Int?
    public let lovedBy: String?
    public let postedBy: String
    public let postedById: Int
    public let postedCount: Int
    public let postedByDescription: String
    public let datePosted: NSDate
    public let audioUnavailable: Bool
    public let tags: [Genre]

    public var postURL: NSURL! = nil
    public var iTunesURL: NSURL! = nil
    public var playlist: Playlist? = nil
    
    public required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("itemid") as! String
        
        let artistJSON = representation.valueForKeyPath("artist") as? String
        if artistJSON == nil || artistJSON == "" {
            self.artist = "Unknown artist"
        } else {
            self.artist = artistJSON!
        }
        
        let titleJSON = representation.valueForKeyPath("title") as? String
        if titleJSON == nil || titleJSON == "" {
            self.title = "Unknown track"
        } else {
            self.title = titleJSON!
        }

        if representation.valueForKeyPath("ts_loved_me") is Int {
            self.loved = true
        } else {
            self.loved = false
        }
        
        self.lovedCount = representation.valueForKeyPath("loved_count") as! Int
        self.lovedCountNum = NSNumber(integer: lovedCount)
        
        if let thumb_url = representation.valueForKeyPath("thumb_url") as? String {
            self.thumbURLSmall = NSURL(string: thumb_url)
        } else {
            self.thumbURLSmall = nil
        }
        
        if let thumb_url_medium = representation.valueForKeyPath("thumb_url_medium") as? String {
            self.thumbURLMedium = NSURL(string: thumb_url_medium)
        } else {
            self.thumbURLMedium = nil
        }
        
        if let thumb_url_large = representation.valueForKeyPath("thumb_url_large") as? String {
            self.thumbURLLarge = NSURL(string: thumb_url_large)
        } else {
            self.thumbURLLarge = nil
        }
        
        self.rank = representation.valueForKeyPath("rank") as? Int
        self.lovedBy = representation.valueForKeyPath("via_user") as? String
        self.postedBy = representation.valueForKeyPath("sitename") as! String
        self.postedById = representation.valueForKeyPath("siteid") as! Int
        self.postedCount = representation.valueForKeyPath("posted_count") as! Int
        self.postedByDescription = (representation.valueForKeyPath("description") as? String) ?? "No description available"
        self.datePosted = NSDate(timeIntervalSince1970: representation.valueForKeyPath("dateposted") as! NSTimeInterval)
        if let pub_audio_unavail = representation.valueForKeyPath("pub_audio_unavail") as? Bool {
            self.audioUnavailable = pub_audio_unavail
        } else {
            self.audioUnavailable = false
        }
        
        let response = NSHTTPURLResponse()
        self.tags = [
            Genre(response: response, representation: ["tag_name": "electronic"])!,
            Genre(response: response, representation: ["tag_name": "indie"])!,
            Genre(response: response, representation: ["tag_name": "new rave"])!,
            Genre(response: response, representation: ["tag_name": "experimental"])!,
            Genre(response: response, representation: ["tag_name": "pop"])!,
            Genre(response: response, representation: ["tag_name": "british"])!,
            Genre(response: response, representation: ["tag_name": "2k11 mix"])!,
            Genre(response: response, representation: ["tag_name": "2011"])!,
        ]
        
        super.init()
        
        self.postURL = NSURL(string: cleanURLString(representation.valueForKeyPath("posturl") as! String))
        self.iTunesURL = NSURL(string: cleanURLString(representation.valueForKeyPath("itunes_link") as! String))
    }
    
    public class func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [Track]? {
        var tracks = [Track]()
        
        if let collectionJSON = representation as? [NSDictionary] {
            for trackJSON in collectionJSON {
                if let track = Track(response: response, representation: trackJSON) {
                    tracks.append(track)
                }
            }
        } else {
            return nil
        }
        
        return tracks
    }
    
    public func mediaURL() -> NSURL {
        var mediaLinkString = "https://hypem.com/serve/public/\(id)?key=\(ApiKey)"
        return NSURL(string: mediaLinkString)!
    }
    
    public func thumbURLWithPreferedSize(size: Track.ImageSize) -> NSURL {
        switch size {
        case .Large:
            if thumbURLLarge != nil {
                return thumbURLLarge!
            } else if thumbURLMedium != nil {
                return thumbURLMedium!
            } else {
                return thumbURLSmall!
            }
        case .Medium:
            if thumbURLMedium != nil {
                return thumbURLMedium!
            } else if thumbURLLarge != nil {
                return thumbURLLarge!
            } else {
                return thumbURLSmall!
            }
        case .Small:
            if thumbURLSmall != nil {
                return thumbURLSmall!
            } else if thumbURLMedium != nil {
                return thumbURLMedium!
            } else {
                return thumbURLLarge!
            }
        }
    }
    
    public func hypeMachineURL() -> NSURL {
        return NSURL(string: "http://hypem.com/track/\(id)")!
    }
    
    private func cleanURLString(URLString: String) -> String {
        let unescapedString = URLString.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let escapedString = unescapedString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
        return escapedString
    }
    
    public enum ImageSize {
        case Small
        case Medium
        case Large
    }
}
