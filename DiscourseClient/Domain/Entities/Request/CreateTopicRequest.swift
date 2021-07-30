//
//  CreateTopicRequest.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

struct CreateTopicRequest: APIRequest {
    typealias Response = CreateTopicResponse
    
    let title: String
    let raw: String
    let createdAt: String
    
    init(title: String, raw: String, createdAt: String) {
        self.title = title
        self.raw = raw
        self.createdAt = createdAt
    }

    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/posts.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "title": title,
            "raw": raw,
            "created_at": createdAt
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
