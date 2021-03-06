//
//  Tag.swift
//  Plug
//
//  Created by Alex Marchant on 8/1/14.
//  Copyright (c) 2014 Plug. All rights reserved.
//

import Cocoa

public struct Tag {
    public let name: String
    public let priority: Bool

    public init(name: String, priority: Bool) {
        self.name = name;
        self.priority = priority;
    }
}

extension Tag: CustomStringConvertible {
    public var description: String {
        return "Tag: { name: \(name), priority: \(priority) }"
    }
}

extension Tag: ResponseObjectSerializable, ResponseCollectionSerializable {
    public init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let name = representation["tag_name"] as? String
            else { return nil }
        
        self.name = name
        self.priority = representation["priority"] as? Bool ?? false
    }
}

extension Tag: Equatable {
    public static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Tag: Hashable {
    public var hashValue: Int {
        return name.hashValue
    }
}
