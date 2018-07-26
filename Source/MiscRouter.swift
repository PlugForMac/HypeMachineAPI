//
//  MiscRouter.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/11/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift

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
            let serialNumber = GetSerialNumber()!
            let hashedSerialNumber = serialNumber.md5()
            print(hashedSerialNumber)
            return hashedSerialNumber
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
