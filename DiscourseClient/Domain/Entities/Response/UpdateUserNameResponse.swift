//
//  UpdateUserNameResponse.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

struct UpdateUserNameResponse: Codable {
    let success: String
    let user: UserDetail
}
