//
//  Genre.swift
//  Plug
//
//  Created by Alex Marchant on 8/1/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public class Genre: NSObject {
    let name: String
    let priority: Bool
    
    override public var description: String {
        return "<Genre - name: \(name), priority: \(priority)>"
    }
    
    public required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.name = (representation.valueForKeyPath("tag_name") as! String).capitalizedString
        if let priorityJSON = representation.valueForKeyPath("priority") as? Bool {
            self.priority = priorityJSON
        } else {
            self.priority = false
        }
    }
}