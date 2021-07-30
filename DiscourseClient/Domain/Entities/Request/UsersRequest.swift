//
//  UsersRequest.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

class UsersRequest: APIRequest {
    typealias Response = UsersResponse
    
    var method: Method {
        return .GET
    }
 
    var path: String {
        return "/directory_items.json"
    }
    
    var parameters: [String : String] {
        return ["period":"all"]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
