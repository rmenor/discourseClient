//
//  CreateTopicUseCases.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol CreateTopicUseCases {
    func createTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<CreateTopicResponse?, Error>) -> ())
}

extension DataManager: CreateTopicUseCases {
    func createTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<CreateTopicResponse?, Error>) -> ()) {
        remoteDataManager.createTopic(title: title, raw: raw, createdAt: createdAt, completion: completion)
    }
}

extension RemoteDataManager: CreateTopicUseCases {
    func createTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<CreateTopicResponse?, Error>) -> ()) {
        let createTopicRequest = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.request(request: createTopicRequest, completion: completion)
    }
}
