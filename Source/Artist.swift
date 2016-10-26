//
//  Artist.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Cocoa

public struct Artist: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    public let name: String
    public let thumbURL: URL?
    public let cnt: Int?
    public let rank: Int?
    
    public var description: String {
        return "Artist: { name: \(name) }"
    }
    
    public init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let name = representation["artist"] as? String
        else { return nil }
        
        func urlForJSONKey(_ key: String) -> URL? {
            guard let urlString = representation[key] as? String else {
                return nil
            }
            return URL(string: urlString)
        }
        
        self.name = name
        self.thumbURL = urlForJSONKey("thumb_url_artist")
        self.cnt = representation["cnt"] as? Int
        self.rank = representation["rank"] as? Int
    }
}
