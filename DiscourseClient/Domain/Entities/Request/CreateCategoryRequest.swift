//
//  CreateCategoryRequest.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

struct CreateCategoryRequest: APIRequest {
    typealias Response = CreateCategoryResponse
    
    let name: String
    let color: String
    let createdAt: String
    
    init(name: String, color: String, createdAt: String) {
        self.name = name
        self.color = color
        self.createdAt = createdAt
    }

    var method: Method {
        return .POST
    }
    
    var path: String {
        return "/categories.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "name": name,
            "color": color,
            "created_at": createdAt
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
