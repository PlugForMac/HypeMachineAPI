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
        public static func index(#optionalParams: [String: AnyObject]?, callback: (blogs: [Blog]?, error: NSError?)->Void) {
            Alamofire.request(Router.Blogs.Index(optionalParams)).validateAPI().validate().responseCollection {
                (request, response, blogs: [Blog]?, error) in
                callback(blogs: blogs, error: error)
            }
        }
        
        public static func show(#id: Int, callback: (blog: Blog?, error: NSError?)->Void) {
            Alamofire.request(Router.Blogs.Show(id)).validateAPI().validate().responseObject {
                (request, response, blog: Blog?, error) in
                callback(blog: blog, error: error)
            }
        }
        
        public static func showTracks(#id: Int, optionalParams: [String: AnyObject]?, callback: (tracks: [Track]?, error: NSError?)->Void) {
            Alamofire.request(Router.Blogs.ShowTracks(id, optionalParams)).validateAPI().validate().responseCollection {
                (request, response, tracks: [Track]?, error) in
                callback(tracks: tracks, error: error)
            }
        }
    }
}