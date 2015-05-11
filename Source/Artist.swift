//
//  Artist.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Cocoa

public final class Artist: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    public let name: String
    public let thumbURL: NSURL?
    public let cnt: Int?
    public let rank: Int?
    
    override public var description: String {
        return "<Artist - name: \(name)>"
    }
    
    public required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.name = representation.valueForKeyPath("artist") as! String
        
        if let thumbURLString = representation.valueForKeyPath("thumb_url_artist") as? String {
            self.thumbURL = NSURL(string: thumbURLString)
        } else {
            self.thumbURL = nil
        }
        
        self.cnt = representation.valueForKeyPath("cnt") as? Int
        self.rank = representation.valueForKeyPath("rank") as? Int
    }
    
    public class func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [Artist]? {
        var artists = [Artist]()
        
        if let collectionJSON = representation as? [NSDictionary] {
            for recordJSON in collectionJSON {
                if let artist = Artist(response: response, representation: recordJSON) {
                    artists.append(artist)
                }
            }
        } else {
            return nil
        }
        
        return artists
    }
}
