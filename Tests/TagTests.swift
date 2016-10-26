//
//  TagsTests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Cocoa
import XCTest
@testable import HypeMachineAPI

class TagTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testBuildTag() {
        let json: AnyObject = Helpers.loadJSONFixtureFile("Tag", ofType: "json")
        let tag = HypeMachineAPI.Tag(response: HTTPURLResponse(), representation: json)
        
        XCTAssertNotNil(tag)
        XCTAssert(tag!.name == "electronic")
    }
    
    func testBuildTagCollection() {
        let json: AnyObject = Helpers.loadJSONFixtureFile("Tags", ofType: "json")
        let tags = HypeMachineAPI.Tag.collection(from: HTTPURLResponse(), withRepresentation: json)
        
        XCTAssertNotNil(tags)
        XCTAssert(tags.count == 3)
    }
}
