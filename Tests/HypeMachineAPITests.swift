//
//  HypeMachineAPITests.swift
//  HypeMachineAPITests
//
//  Created by Alex Marchant on 5/10/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Cocoa
import HypeMachineAPI
import XCTest

class HypeMachineAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBuildTrack() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("Track", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        let track = HypeMachineAPI.Track(response: NSHTTPURLResponse(), representation: jsonResult)

        XCTAssertNotNil(track)
        XCTAssert(track!.id == "2b8fz")
    }
    
    func testBuildTrackCollection() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("Tracks", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
        var jsonResult = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSArray
        
        let tracks = HypeMachineAPI.Track.collection(response: NSHTTPURLResponse(), representation: jsonResult)
        
        XCTAssertNotNil(tracks)
        XCTAssert(tracks!.count == 3)
    }
}
