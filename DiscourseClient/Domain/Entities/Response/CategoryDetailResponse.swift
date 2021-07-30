//
//  CategoryDetailResponse.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

struct CategoryDetailResponse: Codable {
    let category: CategoryDetail
}

struct CategoryDetail: Codable {
    let id: Int
    let name: String
    let color: String
    
    // Mach de datos
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
    }
}
