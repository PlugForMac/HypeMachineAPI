import XCPlayground
import Foundation
import HypeMachineAPI

// Allow network requests to complete
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

func callback(result: Result<[Blog]>) {
    print(result)
}

HypeMachineAPI.Requests.Blogs.index(optionalParams: nil, callback: callback)
