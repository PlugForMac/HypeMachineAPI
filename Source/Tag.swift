//
//  Tag.swift
//  Plug
//
//  Created by Alex Marchant on 8/1/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public final class Tag: NSObject, ResponseObjectSerializable, ResponseCollectionSerializable {
    public let name: String
    public let priority: Bool
    
    override public var description: String {
        return "<Tag - name: \(name), priority: \(priority)>"
    }
    
    public required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.name = representation.valueForKeyPath("tag_name") as! String
        if let priorityJSON = representation.valueForKeyPath("priority") as? Bool {
            self.priority = priorityJSON
        } else {
            self.priority = false
        }
    }
    
    public class func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Tag] {
        var tags = [Tag]()
        
        if let collectionJSON = representation as? [NSDictionary] {
            for recordJSON in collectionJSON {
                if let tag = Tag(response: response, representation: recordJSON) {
                    tags.append(tag)
                }
            }
        }
        
        return tags
    }
}