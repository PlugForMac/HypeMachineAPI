import XCPlayground
import Foundation
import Alamofire
import HypeMachineAPI

// Allow network requests to complete
XCPSetExecutionShouldContinueIndefinitely()

var a = "asdf"

Alamofire.request(HypeMachineAPI.Router.Tracks.Index)
    .responseCollection { (request, response, tracks: [HypeMachineAPI.Track]?, error) in
        println(tracks)
    }