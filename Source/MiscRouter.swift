//
//  MiscRouter.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

extension Router {
    public enum Misc: URLRequestConvertible {
        
        case getToken(usernameOrEmail: String, password: String)
        
        var method: HTTPMethod {
            switch self {
            case .getToken:
                return .post
            }
        }
        
        var path: String {
            switch self {
            case .getToken:
                return "/get_token"
            }
        }
        
        var params: Parameters? {
            switch self {
            case .getToken(let usernameOrEmail, let password):
                return [
                    "username": usernameOrEmail as AnyObject,
                    "password": password as AnyObject,
                    "device_id": DeviceID() as AnyObject,
                ]
            }
        }
        
        public func asURLRequest() throws -> URLRequest {
            return try Router.GenerateURLRequest(method: method, path: path, params: params)
        }
        
        
        func DeviceID() -> String {
            // Should probably hash the serial number instead of just adding 0's
            var deviceID: String
            let deviceIDLength = 16
            
            deviceID = GetSerialNumber()!
            let pad = deviceIDLength - deviceID.characters.count
            
            for _ in 1...pad {
                deviceID = deviceID + "0"
            }
            
            return deviceID
        }
        
        func GetSerialNumber() -> String? {
            var serial: String? = nil
            var platformExpert: io_service_t?
            
            platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
            
            if platformExpert != nil {
                serial = IORegistryEntryCreateCFProperty(platformExpert!, kIOPlatformSerialNumberKey as CFString!, kCFAllocatorDefault, 0).takeRetainedValue() as? String
                IOObjectRelease(platformExpert!)
            }
            
            return serial
        }
    }
}
