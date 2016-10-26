# HypeMachineAPI

This is a partial implementation of the Hype Machine API in Swift. It is currently targetted at OSX but could easily be modified to work for iOS as well. Please create a pull request if you'd like iOS support.

## Installation

### Carthage

```ogdl
github "PlugForMac/HypeMachineAPI" ~> VERSION_NUMBER
```

### CocoaPods

```ruby
platform :osx, '10.10'
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

This API is build on top of Alamofire and is very heavily influenced by its data types. We use their DataResponse in the response for all requests and we also use their Result type. Please check out their documentation for more info.

All requests also return the an Alamofire DataRequest so that you can chain validations or make other modifications to the request.

You can find the source for all requests in the `Requests` folder.
