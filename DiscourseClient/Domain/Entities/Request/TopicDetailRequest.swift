//
//  TopicDetailRequest.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

struct TopicDetialRequest: APIRequest {
    typealias Response = TopicDetailResponse
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }

    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/t/\(id).json"
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
