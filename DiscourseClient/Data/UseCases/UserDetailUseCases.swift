//
//  UserDetailUseCases.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol UserDetailUseCases {
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ())
    func fetchUpdateUserName(username: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> ())
}

extension DataManager: UserDetailUseCases {
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ()) {
        remoteDataManager.fetchUser(username: username, completion: completion)
    }
    
    func fetchUpdateUserName(username: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> ()) {
        remoteDataManager.fetchUpdateUserName(username: username, name: name, completion: completion)
    }
}

extension RemoteDataManager: UserDetailUseCases {
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ()) {
        let request = UserDetailRequest(username: username)
        session.request(request: request) { result in
            completion(result)
        }
    }
    func fetchUpdateUserName(username: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> ()) {
        let request = UpdateUserNameRequest(username: username, name: name)
        session.request(request: request) { result in
            completion(result)
        }
    }
}
