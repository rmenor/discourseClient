//
//  CategoriesResponse.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

struct CategoriesResponse: Codable {
    let categoryList: CategoryList
    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

struct CategoryList: Codable {
    let canCreateCategory: Bool
    let canCreateTopic: Bool
    let categories: [Category]
    enum CodingKeys: String, CodingKey {
        case canCreateCategory = "can_create_category"
        case canCreateTopic = "can_create_topic"
        case categories
    }
}

struct Category: Codable {
    let id: Int
    let name: String
    let color: String
    enum CondingKeys: String, CodingKey {
        case name
        case color
    }
}
