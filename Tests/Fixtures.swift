//
//  Fixtures.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation

class Helpers {
    class func loadJSONFixtureFile(_ name: String, ofType ext: String) -> AnyObject {
        let path = Bundle(for: type(of: Helpers())).path(forResource: name, ofType: ext)!
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
    }
}
