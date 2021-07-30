//
//  CategoryDetailUseCases.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol CategoryDetailUseCases {
    func fetchCategory(id: Int, completion: @escaping (Result<CategoryDetailResponse?, Error>) -> ())
}

extension DataManager: CategoryDetailUseCases {
    func fetchCategory(id: Int, completion: @escaping (Result<CategoryDetailResponse?, Error>) -> ()) {
        remoteDataManager.fetchCategory(id: id, completion: completion)
    }
}

extension RemoteDataManager: CategoryDetailUseCases {
    func fetchCategory(id: Int, completion: @escaping (Result<CategoryDetailResponse?, Error>) -> ()) {
        let request = CategoryDetailRequest(id: id)
        session.request(request: request) { result in
            completion(result)
        }
    }
}
