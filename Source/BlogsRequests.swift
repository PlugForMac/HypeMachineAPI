//
//  BlogsRequests.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/13/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Requests {
    public struct Blogs {
        public static func Index(optionalParams: [String: AnyObject]?, response: (blogs: [Blog]?, error: NSError?)->Void) {
            Alamofire.request(Router.Blogs.Index(optionalParams)).validate().responseCollection {
                (_, _, blogs: [Blog]?, error) in
                response(blogs: blogs, error: error)
            }
        }
        
        public static func Show(#id: String, response: (blog: Blog?, error: NSError?)->Void) {
            Alamofire.request(Router.Blogs.Show(id)).validate().responseObject {
                (_, _, blog: Blog?, error) in
                response(blog: blog, error: error)
            }
        }
        
        public static func ShowTracks(#id: String, optionalParams: [String: AnyObject]?, response: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Blogs.ShowTracks(id, optionalParams)).validate().responseCollection {
                (_, _, tracks: [Track]?, error) in
                response(tracks: tracks, error: error)
            }
        }
    }
}