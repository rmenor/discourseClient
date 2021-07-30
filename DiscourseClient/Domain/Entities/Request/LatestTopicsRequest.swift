//
//  LatestTopicsRequest.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

struct LatestTopicsRequest: APIRequest {
    typealias Response = LatestTopicsResponse

    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/latest.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
