# HypeMachineAPI

This is a partial implementation of the Hype Machine API in Swift. It is currently targetted at OSX but could easily be modified to work for iOS as well. Please create a pull request if you'd like iOS support.

## Swift Compatability

Version 1.0 and beyond have been updated to work with Swift 3. Use the previous version, 0.5.4, for Swift 2.2. 

## Installation

### Carthage

```ogdl
github "PlugForMac/HypeMachineAPI" ~> VERSION_NUMBER
```

### CocoaPods

```ruby
platform :osx, '10.11'
use_frameworks!

pod 'HypeMachineAPI', '~> VERSION_NUMBER'
```

## Use

```swift
HypeMachineAPI.Requests.Blogs.index { response in
    switch response.result {
    case .success(let blogs):
        print(blogs)
    case .failure(let error):
        print(error)
    }
}
```

This API is build on top of Alamofire and uses it's data types extensively. We use their DataResponse as the response for all requests, we also use their Result type to determine success or failure. Please check out their documentation for more info.

Note: requests return an instance of Alamofire DataRequest so that you can chain additional validations or make other modifications to the request if you need to.

You can find the source for all requests in the `Source/*Request.swift` files.
