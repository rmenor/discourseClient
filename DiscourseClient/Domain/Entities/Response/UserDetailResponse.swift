//
//  UserDetailResponse.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

struct UserDetailResponse: Codable {
    let user: UserDetail
}

struct UserDetail: Codable {
    let id: Int
    let username: String
    let name: String?
    let canEditName: Bool
    
    // Mach de datos
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case canEditName = "can_edit_name"
    }
}
