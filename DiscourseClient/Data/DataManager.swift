//
//  DataManager.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

class DataManager {
    let remoteDataManager: RemoteDataManager
    
    init(remoteDataManager: RemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
}

extension DataManager: UsersUseCases {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllUsers(completion: completion)
    }
}
