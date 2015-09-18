//
//  ResponseObjectSerializable.swift
//  HypeMachineAPI
//
//  Created by Alex Marchant on 5/10/15.
//  Copyright (c) 2015 Plug. All rights reserved.
//

import Foundation
import Alamofire

// MARK: ResponseObject

public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: AnyObject)
}

extension Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<T>) -> Void) -> Self {
        let responseSerializer = GenericResponseSerializer<T> { request, response, data in
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data)
            
            switch result {
            case .Success(let value):
                if let
                    response = response,
                    responseObject = T(response: response, representation: value)
                {
                    return .Success(responseObject)
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(data, error)
                }
            case .Failure(let data, let error):
                return .Failure(data, error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

// MARK: ResponseCollection

public protocol ResponseCollectionSerializable {
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
}

extension Alamofire.Request {
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: (NSURLRequest?, NSHTTPURLResponse?, Result<[T]>) -> Void) -> Self {
        let responseSerializer = GenericResponseSerializer<[T]> { request, response, data in
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONSerializer.serializeResponse(request, response, data)
            
            switch result {
            case .Success(let value):
                if let response = response {
                    return .Success(T.collection(response: response, representation: value))
                } else {
                    let failureReason = "Response collection could not be serialized due to nil response"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(data, error)
                }
            case .Failure(let data, let error):
                return .Failure(data, error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

// Custom errors from validations

extension Alamofire.Request {
    public func validateAPI() -> Self {
        return validate { idk, response in
            
            
            return .Success
            
//            if acceptableStatusCode.contains(response.statusCode) {
//                return .Success
//            } else {
//                let failureReason = "Response status code was unacceptable: \(response.statusCode)"
//                return .Failure(Error.errorWithCode(.StatusCodeValidationFailed, failureReason: failureReason))
//            }
        }
//        delegate.queue.addOperationWithBlock {
//            if let response = self.response where self.delegate.error == nil {
//                let JSONSerializer = Alamofire.Request.JSONResponseSerializer(options: .AllowFragments)
//                let (JSON, serializationError): (AnyObject?, NSError?) = JSONSerializer(NSURLRequest(), nil, self.delegate.data)
//                let APIError = Errors.parseAPIErrorFromJSON(JSON)
//                self.delegate.error = APIError
//            }
//        }
    }
}