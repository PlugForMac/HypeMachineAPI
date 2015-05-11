import XCPlayground
import Foundation
import Alamofire
import HypeMachineAPI

// Allow network requests to complete
XCPSetExecutionShouldContinueIndefinitely()

Alamofire.request(HypeMachineAPI.Router.Tracks.Popular(nil))
    .responseCollection { (request, response, tracks: [HypeMachineAPI.Track]?, error) in
        println(tracks![0].title)
        println(error)
    }