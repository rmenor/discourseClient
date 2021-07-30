//
//  UsersUseCases.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol UsersUseCases {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
}

extension RemoteDataManager: UsersUseCases {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        let request = UsersRequest()
        session.request(request: request) { result in
            completion(result)
        }
    }
}
