//
//  CreateCategoryUseCases.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol CreateCategoryUseCases {
    func createCategory(name: String, color: String, createdAt: String, completion: @escaping (Result<CreateCategoryResponse?, Error>) -> ())
}

extension DataManager: CreateCategoryUseCases {
    func createCategory(name: String, color: String, createdAt: String, completion: @escaping (Result<CreateCategoryResponse?, Error>) -> ()) {
        remoteDataManager.createCategory(name: name, color: color, createdAt: createdAt, completion: completion)
    }
}

extension RemoteDataManager: CreateCategoryUseCases {
    func createCategory(name: String, color: String, createdAt: String, completion: @escaping (Result<CreateCategoryResponse?, Error>) -> ()) {
        let createCategoryRequest = CreateCategoryRequest(name: name, color: color, createdAt: createdAt)
        session.request(request: createCategoryRequest, completion: completion)
    }
}
